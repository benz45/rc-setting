
import 'package:flutter/material.dart';
import 'package:rc_setting/model/screen_size_model.dart';
import 'package:rc_setting/provider/setting_provider.dart';
import 'package:provider/provider.dart';

class SightDistanceDropdown extends StatefulWidget {
  const SightDistanceDropdown({super.key});

  @override
  State<SightDistanceDropdown> createState() => _SightDistanceDropdownState();
}

class _SightDistanceDropdownState extends State<SightDistanceDropdown> {
  late ScreenSizeModel _screenSize;

  late SettingProvider _settingProvider;

  @override
  void initState() {
    super.initState();
    _settingProvider = context.read<SettingProvider>();
    _screenSize = _settingProvider.getScreenSize;
  }

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return DropdownButton<ScreenSizeModel>(
      value: _screenSize,
      elevation: 16,
      underline: Container(
        height: 2,
      ),
      onChanged: (ScreenSizeModel? value) {
        if (value != null && value.width != 0) {
          setState(() {
            _screenSize = value;
          });
        }
      },
      items: settingProvider.getScreenSizeList
          .map<DropdownMenuItem<ScreenSizeModel>>((ScreenSizeModel value) {
        return DropdownMenuItem<ScreenSizeModel>(
          value: value,
          child: Text(
            value.getText(),
            style: const TextStyle(fontSize: 12),
          ),
        );
      }).toList(),
    );
  }
}
