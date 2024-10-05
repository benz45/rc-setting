import 'package:flutter/material.dart';
import 'package:rc_setting/model/base_option_model.dart';
import 'package:rc_setting/provider/setting_provider.dart';
import 'package:provider/provider.dart';

class ScreenFramerateDropdown extends StatefulWidget {
  const ScreenFramerateDropdown({super.key});

  @override
  State<ScreenFramerateDropdown> createState() =>
      _ScreenFramerateDropdownState();
}

class _ScreenFramerateDropdownState extends State<ScreenFramerateDropdown> {

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return DropdownButton<BaseOpntionModel<int>>(
      value: settingProvider.getScreenFramerate,
      elevation: 16,
      underline: Container(
        height: 2,
      ),
      onChanged: (BaseOpntionModel<int>? value) {
        if (value != null) {
          settingProvider.setScreenFramerate(value);
        }
      },
      items: settingProvider.getScreenFramerateList
          .map<DropdownMenuItem<BaseOpntionModel<int>>>(
              (BaseOpntionModel<int> value) {
        return DropdownMenuItem<BaseOpntionModel<int>>(
          value: value,
          child: Text(
            value.title,
            style: const TextStyle(fontSize: 12),
          ),
        );
      }).toList(),
    );
  }
}
