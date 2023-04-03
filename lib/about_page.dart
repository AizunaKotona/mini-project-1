import 'package:flutter/material.dart';

class AboutMyTeamPage extends StatelessWidget {
  const AboutMyTeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เกี่ยวกับทีมของฉัน'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ชื่อทีม:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'ZODIAC',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'สมาชิกในทีม:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('1. วัชรากร แก้วล้ำ (ID: 116430462016-7)'),
            const SizedBox(height: 8),
            const Text('2. นายปัญญากร หลวงผิวเดช (ID: 116430462009-2)'),
            const SizedBox(height: 8),
            const Text('3. นายอาทิตย์ ยิ้มเจริญ (ID: 116430462023-3)'),
          ],
        ),
      ),
    );
  }
}
