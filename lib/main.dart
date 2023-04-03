import 'package:flutter/material.dart';
import 'login_page.dart';
import 'novel_edit_page.dart';
import 'novelmodel.dart';
import 'usermodel.dart';
import 'home.dart';
import 'profile_page.dart';
import 'database_helper.dart';
import 'settings_page.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'usermodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final List<String> _novelTitles = [
    'ต้องมนตร์กลใจ',
    'ทัณฑ์รักจอมมาร',
    'ทิวาพราวแสง',
    'นางสาวพราวเสน่ห์',
    'นางสาว18มงกุฎ',
    'น้ำเกลือกับน้ำมนต์',
    'บัญชารักเทพบุตรเถื่อน',
    'บุพเพอุบัติรัก',
  ];

  final List<String> _novelImages = [
    'assets/Images/book_detail_large_1.gif',
    'assets/Images/large_1.jpg',
    'assets/Images/2023-04-02_181427_1.png',
    'assets/Images/1000186733_front_XXL_1.jpg',
    'assets/Images/1.jpg',
    'assets/Images/9789740208259l_1.gif',
    'assets/Images/1000134070_front_XXL_1.jpg',
    'assets/Images/9036890_250_1.jpg',
  ];

  final List<String> _novelSource = [
    'http://164.115.43.80/eBooks/%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%B2%E0%B8%A2/%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%B2%E0%B8%A2%E0%B8%88%E0%B8%B5%E0%B8%99/%e0%b8%95%e0%b9%89%e0%b8%ad%e0%b8%87%e0%b8%a1%e0%b8%99%e0%b8%95%e0%b8%a3%e0%b9%8c%e0%b8%81%e0%b8%a5%e0%b9%83%e0%b8%88.pdf',
    'http://164.115.43.80/eBooks/%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%B2%E0%B8%A2/%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%B2%E0%B8%A2%E0%B8%88%E0%B8%B5%E0%B8%99/%e0%b8%97%e0%b8%b1%e0%b8%93%e0%b8%91%e0%b9%8c%e0%b8%a3%e0%b8%b1%e0%b8%81%e0%b8%88%e0%b8%ad%e0%b8%a1%e0%b8%a1%e0%b8%b2%e0%b8%a3.pdf',
    'http://164.115.43.80/eBooks/%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%B2%E0%B8%A2/%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%B2%E0%B8%A2%E0%B8%88%E0%B8%B5%E0%B8%99/%e0%b8%97%e0%b8%b4%e0%b8%a7%e0%b8%b2%e0%b8%9e%e0%b8%a3%e0%b8%b2%e0%b8%a7%e0%b9%81%e0%b8%aa%e0%b8%87.pdf',
    'http://164.115.43.80/eBooks/%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%B2%E0%B8%A2/%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%B2%E0%B8%A2%E0%B8%88%E0%B8%B5%E0%B8%99/%e0%b8%99%e0%b8%b2%e0%b8%87%e0%b8%aa%e0%b8%b2%e0%b8%a7%e0%b8%9e%e0%b8%a3%e0%b8%b2%e0%b8%a7%e0%b9%80%e0%b8%aa%e0%b8%99%e0%b9%88%e0%b8%ab%e0%b9%8c.pdf',
    'http://164.115.43.80/eBooks/%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%B2%E0%B8%A2/%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%B2%E0%B8%A2%E0%B8%88%E0%B8%B5%E0%B8%99/%e0%b8%99%e0%b8%b2%e0%b8%87%e0%b8%aa%e0%b8%b2%e0%b8%a718%e0%b8%a1%e0%b8%87%e0%b8%81%e0%b8%b8%e0%b8%8e.pdf',
    'http://164.115.43.80/eBooks/%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%B2%E0%B8%A2/%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%B2%E0%B8%A2%E0%B8%88%E0%B8%B5%E0%B8%99/%e0%b8%99%e0%b9%89%e0%b8%b3%e0%b9%80%e0%b8%81%e0%b8%a5%e0%b8%b7%e0%b8%ad%e0%b8%81%e0%b8%b1%e0%b8%9a%e0%b8%99%e0%b9%89%e0%b8%b3%e0%b8%a1%e0%b8%99%e0%b8%95%e0%b9%8c.pdf',
    'http://164.115.43.80/eBooks/%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%B2%E0%B8%A2/%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%B2%E0%B8%A2%E0%B8%88%E0%B8%B5%E0%B8%99/%e0%b8%9a%e0%b8%b1%e0%b8%8d%e0%b8%8a%e0%b8%b2%e0%b8%a3%e0%b8%b1%e0%b8%81%e0%b9%80%e0%b8%97%e0%b8%9e%e0%b8%9a%e0%b8%b8%e0%b8%95%e0%b8%a3%e0%b9%80%e0%b8%96%e0%b8%b7%e0%b9%88%e0%b8%ad%e0%b8%99.pdf',
    'http://164.115.43.80/eBooks/%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%B2%E0%B8%A2/%E0%B8%99%E0%B8%B4%E0%B8%A2%E0%B8%B2%E0%B8%A2%E0%B8%88%E0%B8%B5%E0%B8%99/%e0%b8%9a%e0%b8%b8%e0%b8%9e%e0%b9%80%e0%b8%9e%e0%b8%ad%e0%b8%b8%e0%b8%9a%e0%b8%b1%e0%b8%95%e0%b8%b4%e0%b8%a3%e0%b8%b1%e0%b8%81.pdf',
  ];

  final dbHelper = DatabaseHelper.instance;
  final db = await dbHelper.database;

  // เพิ่มผู้ใช้แอดมินเฉพาะหากยังไม่มีในฐานข้อมูล
  final users = await dbHelper.queryUserByUsername('admin');
  if (users.isEmpty) {
    await dbHelper
        .insertUser(User(username: 'admin', password: 'admin', role: 'admin'));
  }

  // Loop through the list of novel titles, images, and sources
  for (int i = 0; i < _novelTitles.length; i++) {
    // Check if the novel already exists in the database
    final novels = await dbHelper.queryNovelByTitle(_novelTitles[i]);
    if (novels.isEmpty) {
      // If the novel doesn't exist, add it to the database
      await dbHelper.insertNovel(Novel(
        title: _novelTitles[i],
        imageUrl: _novelImages[i],
        source: _novelSource[i],
      ));
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  get user => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NewNovel - เเอพอ่านนิยาย',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const LoginPage(),
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.user})
      : super(key: key);

  final String title;
  final User user;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onLogoutButtonPressed(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return Home();
      case 1:
        if (widget.user.role == 'admin') {
          return const SettingsPage();
        } else {
          return const Center(
            child: Text(
                'การเข้าถึงไม่ได้รับอนุญาต'), // Thai text for 'Unauthorized access.'
          );
        }
      case 2:
        return ProfilePage(user: widget.user);
      default:
        return const Center(
            child: Text(
                'ข้อผิดพลาด: ดัชนีไม่ถูกต้อง')); // Thai text for 'Error: Invalid index.'
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก', // Thai text for 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'การตั้งค่า', // Thai text for 'Settings'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'โปรไฟล์', // Thai text for 'Profile'
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
