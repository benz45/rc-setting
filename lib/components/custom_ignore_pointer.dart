import 'package:flutter/material.dart';

class CustomerIgnorePointer extends StatefulWidget {
  final bool isBlock;
  final Widget child;
  const CustomerIgnorePointer(
      {super.key, required this.isBlock, required this.child});

  @override
  State<CustomerIgnorePointer> createState() => _CustomerIgnorePointerState();
}

class _CustomerIgnorePointerState extends State<CustomerIgnorePointer> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.isBlock,
      child: Opacity(
        opacity: widget.isBlock ? 0.5 : 1.0,
        child: widget.child,
      ),
    );
  }
}
