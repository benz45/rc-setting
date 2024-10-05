import 'package:flutter/material.dart';
import 'package:rc_setting/business/page_business.dart';

class SettingSoundPage extends StatefulWidget {
  const SettingSoundPage({super.key});

  @override
  State<SettingSoundPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingSoundPage> {
  @override
  void initState() {
    super.initState();
    PageBusiness(context, widget.key).mounted(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          Container(
              alignment: Alignment.topLeft, child: const Text('ตั้งค่าเสียง')),
          const Divider(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(10)),
                ),
                fixedSize: const Size(200, 40)),
            onPressed: () => (),
            child: const Text(
              'บันทึก',
            ),
          )
        ],
      ),
    );
  }
}
