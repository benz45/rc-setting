import 'package:flutter/material.dart';
import 'package:rc_setting/model/screen_size_model.dart';
import 'package:rc_setting/provider/setting_provider.dart';
import 'package:provider/provider.dart';

class ScreenSizeDropdown extends StatefulWidget {
  const ScreenSizeDropdown({super.key});

  @override
  State<ScreenSizeDropdown> createState() => _ScreenSizeDropdownState();
}

class _ScreenSizeDropdownState extends State<ScreenSizeDropdown> {
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return DropdownButton<ScreenSizeModel>(
      value: settingProvider.getScreenSize,
      elevation: 16,
      underline: Container(
        height: 2,
      ),
      onChanged: (ScreenSizeModel? value) {
        if (value != null && value.width != 0) {
          settingProvider.setScreenSize(value.width, value.height);
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
