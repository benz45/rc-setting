
import 'package:flutter/material.dart';
import 'package:rc_setting/model/base_option_model.dart';
import 'package:rc_setting/theme.dart';

class CustomRadio<T> extends StatefulWidget {
  final BaseOpntionModel<T> selectedValue;
  final List<BaseOpntionModel<T>> options;
  final Function(BaseOpntionModel<T> e) onChanged;

  const CustomRadio({
    super.key,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
  });

  @override
  State<CustomRadio<T>> createState() => _CustomRadioState();
}

class _CustomRadioState<T> extends State<CustomRadio<T>> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.options.map(
        (e) {
          return Row(
            children: <Widget>[
              Radio<T>(
                value: e.value,
                groupValue: widget.selectedValue.value,
                activeColor: customDarkAccentColor,
                onChanged: (T? value) {
                  if (value != null) {
                    widget.onChanged(e);
                  }
                },
              ),
              Text(e.title),
            ],
          );
        },
      ).toList(),
    );
  }
}
