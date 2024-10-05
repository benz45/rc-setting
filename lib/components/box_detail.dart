import 'package:flutter/material.dart';
import 'package:rc_setting/theme.dart';

class BoxDetail extends StatelessWidget {
  final Widget child;
  final bool light;

  const BoxDetail({super.key, required this.child, this.light = false});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: light ? customDarkBackgroundColor :  customBoxDetail,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }
}
