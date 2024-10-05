import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:rc_setting/components/list_button.dart';
import 'package:rc_setting/images_path.dart';
import 'package:rc_setting/labels.dart';

class LeftSide extends StatelessWidget {
  const LeftSide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: 200,
      child: Container(
        color: const Color.fromARGB(33, 226, 61, 61),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                WindowTitleBarBox(
                  child: MoveWindow(),
                ),
                Image.asset(
                  primaryLogo,
                ),
                const SizedBox(
                  child: Text(
                    primaryLabel,
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 200,
                  child: ListButton(),
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Text(
                    'Version: beta-1.0',
                    style: TextStyle(
                      color: Color.fromARGB(255, 105, 105, 105),
                    ),
                  ),
                  Text(
                    'Check Update',
                    style: TextStyle(
                      color: Color.fromARGB(255, 240, 117, 117),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
