import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

var windowButtonColor = WindowButtonColors(
  iconNormal: const Color.fromARGB(255, 209, 76, 76),
  mouseOver: const Color.fromARGB(255, 209, 76, 76),
  mouseDown: const Color.fromARGB(255, 24, 24, 24),
  iconMouseOver: const Color.fromARGB(255, 24, 24, 24),
  iconMouseDown: const Color.fromARGB(255, 24, 24, 24),

);

class WindowButtons extends StatelessWidget {
  const WindowButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: windowButtonColor,),
        CloseWindowButton(colors: windowButtonColor,)
      ],
    );
  }
}
