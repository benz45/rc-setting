import 'package:flutter/material.dart';
import 'package:rc_setting/theme.dart';

class SnackBarAlert {
  final BuildContext _context;

  SnackBarAlert(this._context);

  void snackBarAlertError(String text) {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: SizedBox(
          height: 40,
          child: Row(
            children: [
              const Icon(
                Icons.warning_amber,
                color: Color.fromARGB(255, 158, 37, 37),
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              const SizedBox(width: 12,),
              Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 7, 7),
      ),
    );
  }

  void snackBarAlertSuccess(String text) {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: SizedBox(
          height: 40,
          child: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: customDarkSuccessColor,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              const SizedBox(width: 12,),
              Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(173, 3, 3, 3),
      ),
    );
  }
}
