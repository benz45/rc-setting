import 'package:flutter/services.dart';

Future<void> executeBatFile() async {
  const platform = MethodChannel('com.example.app/execute');
  try {
    await platform.invokeMethod('executeBatFile');
  } on PlatformException catch (e) {
    print("Failed to execute .bat file: '${e.message}'.");
  }
}
