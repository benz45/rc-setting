import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rc_setting/business/convert_xml_business.dart';
import 'package:rc_setting/business/directory_business.dart';
import 'package:rc_setting/business/page_business.dart';
import 'package:rc_setting/business/screenRetriever_business.dart';
import 'package:rc_setting/components/box_detail.dart';
import 'package:rc_setting/components/setting_display_page/custom_dropdown.dart';
import 'package:rc_setting/components/setting_display_page/premium_box.dart';
import 'package:rc_setting/components/setting_display_page/screen_mode_radio.dart';
import 'package:rc_setting/components/setting_display_page/screen_size_dropdown.dart';
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

class SettingDisplayPage extends StatefulWidget {
  const SettingDisplayPage({super.key});

  @override
  State<SettingDisplayPage> createState() => _SettingDisplayPageState();
}

class _SettingDisplayPageState extends State<SettingDisplayPage> {
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

  // Future<String> loadOptionFile(BuildContext context) async {
  //   var shell = Shell();
  //   shell.run("assets/rcrb-setting/read_file_option.bat").then((result) {
  //     print(result);
  //   }).catchError((onError) {
  //     print('Shell.run error!');
  //     print(onError);
  //   });
  //   // read_file_option.bat
  //   return await rootBundle
  //       .loadString('assets/rcrb-setting/setting/current_option.xml');
  // }

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
            child: const Text('ตั้งค่าหน้าจอ'),
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
                                    const SizedBox(
                                      height: 35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'หน้าจอ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          ScreenModeRadio(),
                                        ],
                                      ),
                                    ),
                                    settingProvider.getScreenMode.value
                                        ? const SizedBox()
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Row(
                                                children: [
                                                  Text(
                                                    'ป้องกันการทับซ้อนของ Taskbar (แนะนำ)',
                                                    style:
                                                        TextStyle(fontSize: 12),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 4, top: 2),
                                                    child: Icon(
                                                      Icons
                                                          .info_outline_rounded,
                                                      color:
                                                          customDarkPrimaryColor,
                                                      size: 18,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width: 40,
                                                child: FittedBox(
                                                  fit: BoxFit.fill,
                                                  child: Switch(
                                                    value: settingProvider
                                                        .getPreventTaskbarOverlap,
                                                    activeColor: Colors.red,
                                                    onChanged: (bool value) {
                                                      settingProvider
                                                          .setPreventTaskbarOverlap(
                                                              value);
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                    const SizedBox(
                                      height: 35,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'ขนาดหน้าจอ',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          ScreenSizeDropdown(),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 12,
                            ),
                            PremiumBox(
                              isActivated: activateProvider.isActivated,
                              child: BoxDetail(
                                light: true,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 22,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'เฟรมเรท',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          CustomDropdown(
                                            selectedValue: settingProvider
                                                .getScreenFramerate,
                                            options: settingProvider
                                                .getScreenFramerateList,
                                            onChanged: (value) {
                                              settingProvider
                                                  .setScreenFramerate(value);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 22),
                                      child: const Divider(
                                        height: 0.1,
                                        color: Colors.white10,
                                      ),
                                    ),
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'คุณภาพ',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    CustomSliderPerfomance(
                                      selectedValue:
                                          settingProvider.performance,
                                      options:
                                          settingProvider.getPerformanceList,
                                      onChanged: (value) {
                                        settingProvider
                                            .changePerformance(value);
                                      },
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 22),
                                      child: const Divider(
                                        height: 0.1,
                                        color: Colors.white10,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'ระยะการมองเห็น',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          selectedValue:
                                              settingProvider.sightDistance,
                                          options: settingProvider
                                              .getSightDistanceList,
                                          onChanged: (value) {
                                            settingProvider
                                                .setSightDistance(value);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'ปริมาณรถ',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          options: settingProvider
                                              .getCarCountLevelList,
                                          selectedValue:
                                              settingProvider.getCarCountLevel,
                                          onChanged: (e) {
                                            settingProvider.setCarCountLevel(e);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Texture รถ',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          selectedValue:
                                              settingProvider.getCarTexLevel,
                                          options: settingProvider
                                              .getCarTexLevelList,
                                          onChanged: (value) => settingProvider
                                              .setCarTexLevel(value),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'รายละเอียด Effect',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          selectedValue:
                                              settingProvider.getCarEffectLevel,
                                          options: settingProvider
                                              .getCarEffectLevelList,
                                          onChanged: (value) {
                                            settingProvider
                                                .setCarEffectLevel(value);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'เงาสะท้อนของรถ',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          selectedValue:
                                              settingProvider.getEnvmapLevel,
                                          options: settingProvider
                                              .getEnvmapLevelList,
                                          onChanged: (value) {
                                            settingProvider
                                                .setEnvmapLevel(value);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'ภาพ 3 มิติของตึก',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          selectedValue:
                                              settingProvider.getFieldLevel,
                                          options:
                                              settingProvider.getFieldLevelList,
                                          onChanged: (value) {
                                            settingProvider
                                                .setFieldLevel(value);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'ข้อความปลีกย่อย',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          selectedValue:
                                              settingProvider.getTexDetailLevel,
                                          options: settingProvider
                                              .getTexDetailLevelList,
                                          onChanged: (value) {
                                            settingProvider
                                                .setTexDetailLevel(value);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'รายละเอียดของแสง',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          selectedValue: settingProvider
                                              .getLightTexDetailLevel,
                                          options: settingProvider
                                              .getLightTexDetailLevelList,
                                          onChanged: (value) {
                                            settingProvider
                                                .setLightTexDetailLevel(value);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'ภาพสะท้องของตึก',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          selectedValue:
                                              settingProvider.getReflection,
                                          options:
                                              settingProvider.getReflectionList,
                                          onChanged: (value) {
                                            settingProvider
                                                .setReflection(value);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Environment effect',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          selectedValue:
                                              settingProvider.getSceneGlowOn,
                                          options: settingProvider
                                              .getSceneGlowOnList,
                                          onChanged: (value) {
                                            settingProvider
                                                .setSceneGlowOn(value);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Booster effect',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          selectedValue:
                                              settingProvider.getMotionBlurOn,
                                          options: settingProvider
                                              .getMotionBlurOnList,
                                          onChanged: (value) {
                                            settingProvider
                                                .setMotionBlurOn(value);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Antialiasing',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          selectedValue: settingProvider
                                              .getMultiSampleType,
                                          options: settingProvider
                                              .getMultiSampleTypeList,
                                          onChanged: (value) {
                                            settingProvider
                                                .setMultiSampleType(value);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'โพลิกอนของรถ',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          selectedValue:
                                              settingProvider.getCarLodLevel,
                                          options: settingProvider
                                              .getCarLodLevelList,
                                          onChanged: (value) {
                                            settingProvider
                                                .setCarLodLevel(value);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'ดูข้อมูลสัญลักษณ์',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          selectedValue: settingProvider
                                              .getRenderSignboard,
                                          options: settingProvider
                                              .getRenderSignboardList,
                                          onChanged: (value) {
                                            settingProvider
                                                .setRenderSignboard(value);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'ภาพสะท้อน',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          selectedValue: settingProvider
                                              .getWaterReflection,
                                          options: settingProvider
                                              .getWaterReflectionList,
                                          onChanged: (value) {
                                            settingProvider
                                                .setWaterReflection(value);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'ระเบิด',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          selectedValue:
                                              settingProvider.getBloomLevel,
                                          options:
                                              settingProvider.getBloomLevelList,
                                          onChanged: (value) {
                                            settingProvider
                                                .setBloomLevel(value);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'แสงไฟหน้า',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        CustomSlid(
                                          selectedValue:
                                              settingProvider.getDynLight2,
                                          options:
                                              settingProvider.getDynLight2List,
                                          onChanged: (value) {
                                            settingProvider.setDynLight2(value);
                                          },
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  customDarkBackgroundColor,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 1,
                                                    color:
                                                        customDarkSurfaceColor),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6)),
                                              ),
                                            ),
                                            onPressed: () => {},
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Reset',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  activateProvider.isActivated
                      ? Row(
                          children: [
                            CustomProfileButton(
                              label: 'Profile 1',
                              selected: settingProvider.getProfileSelected == 1,
                              useged:
                                  settingProvider.getCurrentProfileUseged == 1,
                              onSelected: () => {settingProvider.setProfile(1)},
                            ),
                            CustomProfileButton(
                              label: 'Profile 2',
                              selected: settingProvider.getProfileSelected == 2,
                              useged:
                                  settingProvider.getCurrentProfileUseged == 2,
                              onSelected: () => {settingProvider.setProfile(2)},
                            ),
                            CustomProfileButton(
                              label: 'Profile 3',
                              selected: settingProvider.getProfileSelected == 3,
                              useged:
                                  settingProvider.getCurrentProfileUseged == 3,
                              onSelected: () => {settingProvider.setProfile(3)},
                            ),
                          ],
                        )
                      : const SizedBox(),
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
          // FutureBuilder<String>(
          //   future: loadOptionFile(context),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.done) {
          //       if (snapshot.hasError) {
          //         return Text('Error: ${snapshot.error}');
          //       }
          //       final xmlString = snapshot.data;
          //       final document = xml.XmlDocument.parse(xmlString!);
          //       final rootElement = document.rootElement;
          //       final graphic = rootElement.getElement('graphic');
          //       final fullScreenWidth =
          //           graphic?.getAttribute('fullScreenWidth');

          //       return Column(
          //         children: [
          //           Row(
          //             mainAxisSize: MainAxisSize.max,
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               const Text(
          //                 'ขนาดหน้าจอในเกมส์ปัจจุบัน',
          //                 style: TextStyle(fontSize: 12),
          //               ),
          //               Text(
          //                 '$fullScreenWidth',
          //                 style: const TextStyle(fontSize: 12),
          //               ),
          //             ],
          //           ),
          //           const Divider()
          //         ],
          //       );
          //     } else {
          //       return const CircularProgressIndicator();
          //     }
          //   },
          // ),
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //       shape: const RoundedRectangleBorder(
          //         borderRadius:
          //             BorderRadius.all(Radius.circular(10)), // No border radius
          //       ),
          //       fixedSize: const Size(200, 40)),
          //   onPressed: () => (),
          //   child: const Text(
          //     "ใช้ขนาดตามหน้าจอ",
          //   ),
          // )
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
