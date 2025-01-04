import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rc_setting/business/convert_xml_business.dart';
import 'package:rc_setting/business/directory_business.dart';
import 'package:rc_setting/business/page_business.dart';
import 'package:rc_setting/business/screenRetriever_business.dart';
import 'package:rc_setting/components/box_detail.dart';
import 'package:rc_setting/components/custom_divider.dart';
import 'package:rc_setting/components/custom_ignore_pointer.dart';
import 'package:rc_setting/components/setting_display_page/premium_box.dart';
import 'package:rc_setting/components/snack_bar_alert.dart';
import 'package:rc_setting/constant/profile_constant.dart';
import 'package:rc_setting/model/base_option_model.dart';
import 'package:rc_setting/model/screen_size_model.dart';
import 'package:rc_setting/model/setting_model.dart';
import 'package:rc_setting/provider/activate_provider.dart';
import 'package:rc_setting/provider/setting_provider.dart';
import 'package:rc_setting/util/validate_util.dart';
import 'package:xml/xml.dart' as xml;
import 'package:xml/xml.dart';

import '../theme.dart';

class SettingSoundPage extends StatefulWidget {
  const SettingSoundPage({super.key});

  @override
  State<SettingSoundPage> createState() => _SettingSoundPageState();
}

class _SettingSoundPageState extends State<SettingSoundPage> {
  late SettingProvider _settingProvider;
  late ActivateProvider _activateProvider;
  late SnackBarAlert _snackBarAlert;
  late ScreenRetrieverBusiness _screenRetrieverBusiness;
  late DirectoryBusiness _directoryBusiness;

  @override
  void initState() {
    super.initState();
    _snackBarAlert = SnackBarAlert(context);
    _settingProvider = context.read<SettingProvider>();
    _activateProvider = context.read<ActivateProvider>();
    _screenRetrieverBusiness = ScreenRetrieverBusiness();
    _directoryBusiness = DirectoryBusiness();
    PageBusiness(context, widget.key).mounted(() async {
      fetchScreenSize();
      ConfigModel? config = await _directoryBusiness.getResourseConfig();
      _settingProvider.setSettingConfig(config);
    });
    setState(() {});
  }

  void onUpdateSetting(ProfileConfig profileConfig) async {
    try {
      File? xmlOptionFile = await _directoryBusiness.getXMLOptionFile();
      if (xmlOptionFile != null) {
        final String contentXML = await xmlOptionFile.readAsString();
        if (isNotNullOrEmpty(contentXML)) {
          final XmlDocument document = xml.XmlDocument.parse(contentXML);
          final XmlElement rootElement = document.rootElement;
          final XmlElement? graphic = rootElement.getElement('graphic');
          ConvertXMLBusiness convertXML = ConvertXMLBusiness();
          convertXML.convertToGraphic(
              graphic, profileConfig, _activateProvider.isActivated);
          await xmlOptionFile
              .writeAsString(document.toXmlString(pretty: true, indent: '  '));
          _snackBarAlert.snackBarAlertSuccess('นำไปใช้สำเร็จ');
        }
      }
    } catch (e) {
      _snackBarAlert.snackBarAlertError('เกิดข้อผิดพลาดบางอย่าง');
      _directoryBusiness.createLogFile(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchScreenSize() async {
    ScreenSizeModel? primaryDisplay =
        await _screenRetrieverBusiness.getScreenSize();
    _settingProvider.addScreenSizeModel(primaryDisplay);
    setState(() {});
  }

  void onSubmit() async {
    ConfigModel? setting = await _directoryBusiness.getResourseConfig();
    if (isNotNullOrEmpty(setting)) {
      setting!.currentProfile = _settingProvider.getProfileSelected;
      ProfileConfig profileConfig = _settingProvider.getCurrentProfileConfig;
      _settingProvider.setProfileUseged(_settingProvider.getProfileSelected);
      switch (_settingProvider.getProfileSelected) {
        case PROFILE_1:
          setting.profile1 = profileConfig;
          break;
        case PROFILE_2:
          setting.profile2 = profileConfig;
          break;
        case PROFILE_3:
          setting.profile3 = profileConfig;
          break;
      }
      _directoryBusiness.updateResourseFile(setting);
      onUpdateSetting(profileConfig);
    }
  }

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    ActivateProvider activateProvider = Provider.of<ActivateProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: const Text('ตั้งค่าเสียง'),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: BoxDetail(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 605,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            BoxDetail(
                              light: true,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 32,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          children: [
                                            Text(
                                              'เสียงดนตรีประกอบ',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 40,
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Switch(
                                              value: settingProvider
                                                  .getIsBgmVloume,
                                              activeColor: Colors.red,
                                              onChanged: (bool value) {
                                                settingProvider
                                                    .setIsBgmOnVloume(value);
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  CustomerIgnorePointer(
                                    isBlock: !settingProvider.getIsBgmVloume,
                                    child: CustomSliderSound(
                                      selectedValue:
                                          settingProvider.getBgmVloume,
                                      options:
                                          settingProvider.getBgmVloumeList,
                                      onChanged: (value) {
                                        settingProvider.setBgmVloume(value);
                                      },
                                    ),
                                  ),
                                  const CustomDivider(),
                                  SizedBox(
                                    height: 32,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          children: [
                                            Text(
                                              'เสียงประกอบ',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 40,
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Switch(
                                              value: settingProvider
                                                  .getIsEffectVloume,
                                              activeColor: Colors.red,
                                              onChanged: (bool value) {
                                                settingProvider
                                                    .setIsEffectOnVloume(
                                                        value);
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  CustomerIgnorePointer(
                                    isBlock:
                                        !settingProvider.getIsEffectVloume,
                                    child: CustomSliderSound(
                                      selectedValue:
                                          settingProvider.getEffectVloume,
                                      options:
                                          settingProvider.getEffectVloumeList,
                                      onChanged: (value) {
                                        settingProvider
                                            .setEffectVloume(value);
                                      },
                                    ),
                                  ),
                                  const CustomDivider(),
                                  SizedBox(
                                    height: 32,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Row(
                                          children: [
                                            Text(
                                              'เสียงเครื่องบนต์',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 40,
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Switch(
                                              value: settingProvider
                                                  .getIsEngineVloume,
                                              activeColor: Colors.red,
                                              onChanged: (bool value) {
                                                settingProvider
                                                    .setIsEngineOnVloume(
                                                        value);
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  CustomerIgnorePointer(
                                    isBlock:
                                        !settingProvider.getIsEngineVloume,
                                    child: CustomSliderSound(
                                      selectedValue:
                                          settingProvider.getEngineVloume,
                                      options:
                                          settingProvider.getEngineVloumeList,
                                      onChanged: (value) {
                                        settingProvider
                                            .setEngineVloume(value);
                                      },
                                    ),
                                  ),
                                  
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        fixedSize: const Size(100, 40)),
                    onPressed: onSubmit,
                    child: const Text(
                      'นำไปใช้',
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CustomProfileButton extends StatefulWidget {
  final String label;
  final bool selected;
  final bool useged;
  final Function() onSelected;
  const CustomProfileButton(
      {super.key,
      required this.label,
      this.selected = false,
      this.useged = false,
      required this.onSelected});

  @override
  State<CustomProfileButton> createState() => _CustomProfileButtonState();
}

class _CustomProfileButtonState extends State<CustomProfileButton> {
  @override
  Widget build(BuildContext context) {
    widget.label;
    return Opacity(
      opacity: widget.selected ? 1.0 : 0.5,
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: customDarkBackgroundColor,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1,
                    color: widget.selected
                        ? customDarkSuccessColor
                        : customDarkSurfaceColor),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              fixedSize: const Size(128, 40)),
          onPressed: widget.onSelected,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.check_circle,
                  color: widget.useged
                      ? customDarkSuccessColor
                      : customDarkSurfaceColor,
                  size: 18.0,
                ),
              ),
              Text(widget.label)
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSlid<T> extends StatefulWidget {
  final BaseOpntionModel<T> selectedValue;
  final List<BaseOpntionModel<T>> options;
  final Function(BaseOpntionModel<T> e) onChanged;
  const CustomSlid({
    super.key,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
  });

  @override
  State<CustomSlid<T>> createState() => _CustomSlidState();
}

class _CustomSlidState<T> extends State<CustomSlid<T>> {
  double slideValue = 0.0;
  int selectedIndex = 0;
  double maxlength = 100.0;
  String label = '';
  late BaseOpntionModel<T> _selectedValue;

  @override
  void initState() {
    setIndex();
    super.initState();
  }

  void setIndex() {
    _selectedValue = widget.selectedValue;
    double grap = maxlength.toInt() / (widget.options.length - 1).toInt();
    for (var i = 0; i <= (widget.options.length - 1); i++) {
      if (_selectedValue.value == widget.options[i].value) {
        setState(() {
          slideValue = grap * i;
          selectedIndex = i;
          label = widget.options[i].title;
        });
        break;
      }
    }
  }

  @override
  void didUpdateWidget(CustomSlid<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValue != oldWidget.selectedValue) {
      setIndex();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Text(
              label,
              style: const TextStyle(fontSize: 10),
            ),
          ),
          SliderTheme(
            data: const SliderThemeData(
              trackHeight: 0.1,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
              valueIndicatorTextStyle: TextStyle(
                  color: Colors.white, fontFamily: 'Kanit-Light', fontSize: 10),
            ),
            child: Slider(
              value: slideValue,
              max: maxlength,
              divisions: widget.options.length - 1,
              label: label,
              activeColor: customDarkAccentColor,
              secondaryActiveColor: Colors.white,
              inactiveColor: Colors.grey.shade700,
              onChanged: (double value) {
                setState(() {
                  double grap = maxlength / (widget.options.length - 1);
                  selectedIndex =
                      value == 0 ? 0 : (value.toInt() ~/ grap.toInt()).toInt();
                  slideValue = value;
                });
                var selected = widget.options[selectedIndex];
                if (selected != null) {
                  label = selected.title;
                  widget.onChanged(selected);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSliderPerfomance<T> extends StatefulWidget {
  final BaseOpntionModel<T> selectedValue;
  final List<BaseOpntionModel<T>> options;
  final Function(BaseOpntionModel<T> e) onChanged;

  const CustomSliderPerfomance({
    super.key,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
  });

  @override
  State<CustomSliderPerfomance<T>> createState() =>
      _CustomSliderPerfomanceState();
}

class _CustomSliderPerfomanceState<T> extends State<CustomSliderPerfomance<T>> {
  double slideValue = 0.0;
  int selectedIndex = 0;
  double maxlength = 100.0;
  String label = '';
  late BaseOpntionModel<T> _selectedValue;
  @override
  void initState() {
    setIndex();
    super.initState();
  }

  void setIndex() {
    _selectedValue = widget.selectedValue;
    double grap = maxlength.toInt() / (widget.options.length - 1).toInt();
    for (var i = 0; i <= (widget.options.length - 1); i++) {
      if (_selectedValue.value == widget.options[i].value) {
        setState(() {
          slideValue = grap * i;
          selectedIndex = i;
          label = widget.options[i].title;
        });
        break;
      }
    }
  }

  @override
  void didUpdateWidget(CustomSliderPerfomance<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValue != oldWidget.selectedValue) {
      setIndex();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
            ),
            child: SliderTheme(
              data: const SliderThemeData(
                trackHeight: 0.1,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
                showValueIndicator: ShowValueIndicator.never,
                valueIndicatorTextStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Kanit-Light',
                    fontSize: 10),
              ),
              child: Slider(
                value: slideValue,
                max: maxlength,
                divisions: widget.options.length - 1,
                label: label,
                activeColor: customDarkAccentColor,
                secondaryActiveColor: Colors.white,
                inactiveColor: Colors.grey.shade700,
                onChanged: (double value) {
                  setState(() {
                    double grap = maxlength / (widget.options.length - 1);
                    selectedIndex = value == 0
                        ? 0
                        : (value.toInt() ~/ grap.toInt()).toInt();
                    slideValue = value;
                  });
                  var selected = widget.options[selectedIndex];
                  if (selected != null) {
                    label = selected.title;
                    widget.onChanged(selected);
                  }
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.options.map((e) {
              return SizedBox(
                width: 70,
                child: Center(
                  child: Text(
                    e.title,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class CustomSliderSound<T> extends StatefulWidget {
  final BaseOpntionModel<T> selectedValue;
  final List<BaseOpntionModel<T>> options;
  final Function(BaseOpntionModel<T> e) onChanged;

  const CustomSliderSound({
    super.key,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
  });

  @override
  State<CustomSliderSound<T>> createState() => _CustomSliderSoundState();
}

class _CustomSliderSoundState<T> extends State<CustomSliderSound<T>> {
  double slideValue = 0.0;
  int selectedIndex = 0;
  double maxlength = 100.0;
  String label = '';
  late BaseOpntionModel<T> _selectedValue;
  @override
  void initState() {
    setIndex();
    super.initState();
  }

  void setIndex() {
    _selectedValue = widget.selectedValue;
    double grap = maxlength.toInt() / (widget.options.length - 1).toInt();
    for (var i = 0; i <= (widget.options.length - 1); i++) {
      if (_selectedValue.value == widget.options[i].value) {
        setState(() {
          slideValue = grap * i;
          selectedIndex = i;
          label = widget.options[i].title;
        });
        break;
      }
    }
  }

  @override
  void didUpdateWidget(CustomSliderSound<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValue != oldWidget.selectedValue) {
      setIndex();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 1,
            ),
            child: SliderTheme(
              data: const SliderThemeData(
                trackHeight: 0.1,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
                showValueIndicator: ShowValueIndicator.never,
                valueIndicatorTextStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Kanit-Light',
                    fontSize: 10),
              ),
              child: Slider(
                value: slideValue,
                max: maxlength,
                divisions: widget.options.length - 1,
                label: label,
                activeColor: customDarkAccentColor,
                secondaryActiveColor: Colors.white,
                inactiveColor: Colors.grey.shade700,
                onChanged: (double value) {
                  setState(() {
                    double grap = maxlength / (widget.options.length - 1);
                    selectedIndex = value == 0
                        ? 0
                        : (value.toInt() ~/ grap.toInt()).toInt();
                    slideValue = value;
                  });
                  var selected = widget.options[selectedIndex];
                  if (selected != null) {
                    label = selected.title;
                    widget.onChanged(selected);
                  }
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widget.options.map((e) {
              return SizedBox(
                width: 30,
                child: Center(
                  child: Text(
                    e.title,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
