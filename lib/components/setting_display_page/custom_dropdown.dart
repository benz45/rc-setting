
import 'package:flutter/material.dart';
import 'package:rc_setting/model/base_option_model.dart';

class CustomDropdown extends StatefulWidget {
  final BaseOpntionModel<int> selectedValue;
  final List<BaseOpntionModel<int>> options;
  final ValueChanged<BaseOpntionModel<int>> onChanged;

  const CustomDropdown({
    super.key,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<BaseOpntionModel<int>>(
      value: widget.selectedValue,
      elevation: 16,
      underline: Container(height: 2),
      onChanged: (BaseOpntionModel<int>? value) {
        if (value != null) {
          widget.onChanged(value);
        }
      },
      items: widget.options.map<DropdownMenuItem<BaseOpntionModel<int>>>(
        (BaseOpntionModel<int> value) {
          return DropdownMenuItem<BaseOpntionModel<int>>(
            value: value,
            child: Text(
              value.title,
              style: const TextStyle(fontSize: 12),
            ),
          );
        },
      ).toList(),
    );
  }
}