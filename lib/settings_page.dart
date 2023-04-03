import 'package:flutter/material.dart';
import 'package:newnovel/about_page.dart';
import 'package:newnovel/scanqr_page.dart';
import 'checkspec.dart';
import 'manage_user_page.dart';
import 'add_novel_page.dart';
import 'novel_list_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          const SizedBox(height: 8.0),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ManageUserPage(),
                ),
              );
            },
            icon: const Icon(Icons.person),
            label: const Text('จัดการผู้ใช้งาน'),
          ),
          const SizedBox(height: 8.0),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckSpecPage(),
                ),
              );
            },
            icon: const Icon(Icons.devices),
            label: const Text('ตรวจสอบข้อมูลอุปกรณ์'),
          ),
          const SizedBox(height: 8.0),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddNovelPage(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('เพิ่มนิยายใหม่'),
          ),
          const SizedBox(height: 8.0),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NovelListPage(),
                ),
              );
            },
            icon: const Icon(Icons.list),
            label: const Text('รายการนิยาย'),
          ),
          const SizedBox(height: 8.0),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QRCodeScannerPage(),
                ),
              );
            },
            icon: const Icon(Icons.qr_code_scanner),
            label: const Text('สแกน QR Code'),
          ),
          const SizedBox(height: 50.0),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutMyTeamPage(),
                ),
              );
            },
            icon: const Icon(Icons.group),
            label: const Text('ทีมของฉัน'),
          ),
        ],
      ),
    );
  }
}
