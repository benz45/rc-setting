import 'package:flutter/material.dart';
import 'package:rc_setting/business/page_business.dart';
import 'package:rc_setting/components/box_detail.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<InfoPage> {
  @override
  void initState() {
    super.initState();
    PageBusiness(context, widget.key).mounted(() async {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BoxDetail(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('นโยบายความเป็นส่วนตัว',
                    style: TextStyle(fontSize: 14, height: 2)),
                Text('วันที่มีผลบังคับใช้: 18 สิงหาคม 2567',
                    style: TextStyle(fontSize: 14, height: 2)),
                SizedBox(
                  height: 12,
                ),
                Text('1. ข้อมูลที่เรารวบรวม',
                    style: TextStyle(fontSize: 12, height: 3)),
                Text(
                    'โปรแกรมตั้งค่า Rebirth RC มีวัตถุประสงค์เพื่อให้ผู้ใช้สามารถตั้งค่าภาพและเสียงของเกม Rebirth RC ก่อนที่จะเข้าไปตั้งค่าในตัวเกมเอง ซึ่งข้อมูลที่เก็บรวมรวมจะไม่เกี่ยวข้องกับข้อมูลส่วนตัว และข้อมูลที่ใช้เข้าสู่ระบบ ข้อมูลที่เรารวบรวมประกอบด้วย:',
                    style: TextStyle(
                        fontSize: 12, height: 2, color: Colors.white60)),
                Text(
                    '- ข้อมูลที่ให้โดยตรง: ข้อมูลที่ผู้ใช้ป้อนลงในโปรแกรม เช่น การตั้งค่าภาพและเสียง',
                    style: TextStyle(
                        fontSize: 12, height: 2, color: Colors.white60)),
                Text(
                    '- ข้อมูลการใช้งาน: ข้อมูลเกี่ยวกับการใช้งานโปรแกรม จะถูกแบ่งเป็น 2 สถานะ คือ ทั่วไป และเต็มรูปแบบ',
                    style: TextStyle(
                        fontSize: 12, height: 2, color: Colors.white60)),
                Text('2. การใช้ข้อมูล',
                    style: TextStyle(fontSize: 12, height: 3)),
                Text(
                    'ข้อมูลที่เรารวบรวมจะถูกใช้เพื่อวัตถุประสงค์ปรับแต่งการตั้งค่าภาพและเสียงของเกม Rebirth RC ให้เหมาะสมกับความต้องการของผู้ใช้',
                    style: TextStyle(
                        fontSize: 12, height: 2, color: Colors.white60)),
                Text('3. สิทธิของผู้ใช้',
                    style: TextStyle(fontSize: 12, height: 3)),
                Text(
                    'ผู้ใช้มีสิทธิในการเข้าถึง แก้ไข หรือขอให้ลบข้อมูลส่วนตัวของตนตามที่เรารวบรวม นอกจากนี้ ผู้ใช้ยังสามารถติดต่อเราเพื่อสอบถามหรือแสดงความคิดเห็นเกี่ยวกับนโยบายความเป็นส่วนตัวนี้',
                    style: TextStyle(
                        fontSize: 12, height: 2, color: Colors.white60)),
                Text('4. การติดต่อเรา',
                    style: TextStyle(fontSize: 12, height: 3)),
                Text(
                    'หากมีคำถามหรือข้อกังวลเกี่ยวกับนโยบายความเป็นส่วนตัวนี้ โปรดติดต่อเราได้ที่:',
                    style: TextStyle(
                        fontSize: 12, height: 2, color: Colors.white60)),
                Text('อีเมล: benz45.th@gmail.com',
                    style: TextStyle(
                        fontSize: 12, height: 2, color: Colors.white60)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
