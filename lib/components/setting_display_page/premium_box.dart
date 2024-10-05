import 'package:flutter/material.dart';
import 'package:rc_setting/components/setting_display_page/premium_button.dart';
import 'package:rc_setting/provider/menu_provider.dart';
import 'package:provider/provider.dart';

class PremiumBox extends StatefulWidget {
  final bool isActivated;
  final Widget child;
  const PremiumBox({super.key, required this.isActivated, required this.child});

  @override
  State<PremiumBox> createState() => _PremiumBoxState();
}

class _PremiumBoxState extends State<PremiumBox> {
  late MenuProvider _menuProvider;
  @override
  void initState() {
    super.initState();
    _menuProvider = context.read<MenuProvider>();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isActivated) {
      return widget.child;
    }
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 255, 213, 77), width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('ปลดล็อกการตั้งค่าเพิ่มเติมอย่างเต็มรูปแบบ',
                    style: TextStyle(fontSize: 12, color: Colors.white)),
                PremiumButton(
                  onTap: () => _menuProvider.updateCurrentPageIndex(0),
                )
              ],
            ),
          ),
          IgnorePointer(
            ignoring: widget.isActivated == false,
            child: Opacity(
              opacity: widget.isActivated == false ? 0.5 : 1.0,
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
