import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'main.dart';
import 'usermodel.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  final dbHelper = DatabaseHelper.instance;

  Future<void> _onLoginButtonPressed(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    List<Map<String, dynamic>> result =
        await dbHelper.queryUserByUsernameAndPassword(username, password);

    if (result.isNotEmpty) {
      User user = User.fromMap(result.first);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            title: 'NewNovel - เเอพอ่านนิยาย',
            user: user,
          ),
        ),
      );
    } else {
      setState(() {
        _errorMessage =
            'ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง'; // Thai text for 'Invalid username or password'
      });
    }
  }

  Future<void> _onRegisterButtonPressed(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, Colors.blueGrey],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'NewNovel - นิยายอ่านฟรี', // Thai text for 'NewNovel - Free Online Novels'
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'ชื่อผู้ใช้', // Thai text for 'Username'
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'รหัสผ่าน', // Thai text for 'Password'
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _onLoginButtonPressed(context),
                      child:
                          const Text('เข้าสู่ระบบ'), // Thai text for 'Log In'
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => _onRegisterButtonPressed(context),
                    child: const Text(
                        'สร้างบัญชีผู้ใช้ใหม่'), // Thai text for 'Create an Account'
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
