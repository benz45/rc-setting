import 'package:flutter/material.dart';

class CustomerIgnorePointer extends StatefulWidget {
  final bool isIgnore;
  final Widget child;
  const CustomerIgnorePointer(
      {super.key, required this.isIgnore, required this.child});

  @override
  State<CustomerIgnorePointer> createState() => _CustomerIgnorePointerState();
}

class _CustomerIgnorePointerState extends State<CustomerIgnorePointer> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.isIgnore == false,
      child: Opacity(
        opacity: widget.isIgnore == false ? 0.5 : 1.0,
        child: widget.child,
      ),
    );
  }
}
