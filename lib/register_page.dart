import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'main.dart';
import 'usermodel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _errorMessage = '';
  final dbHelper = DatabaseHelper.instance;

  Future<void> _onRegisterButtonPressed(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage =
            'โปรดกรอกข้อมูลให้ครบทุกช่อง'; // Thai text for 'Please fill in all fields'
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _errorMessage =
            'รหัสผ่านไม่ตรงกัน'; // Thai text for 'Passwords do not match'
      });
      return;
    }

    final users = await dbHelper.queryUserByUsername(_usernameController.text);
    if (users.isNotEmpty) {
      setState(() {
        _errorMessage =
            'มีชื่อผู้ใช้นี้อยู่แล้ว'; // Thai text for 'Username already exists'
      });
      return;
    }

// Insert new user
    final user = User(
      username: _usernameController.text,
      password: _passwordController.text,
      role: 'user',
    );
    await dbHelper.insertUser(user);

    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(
          title: 'NewNovel - เเอพอ่านนิยาย',
          user: user,
        ),
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
                    'สร้างบัญชีผู้ใช้', // Thai text for 'Create an Account'
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
                        borderRadius: BorderRadius.circular(
                            10), // Missing parenthesis was added here
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText:
                          'ยืนยันรหัสผ่าน', // Thai text for 'Confirm Password'
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
                      onPressed: () => _onRegisterButtonPressed(context),
                      child:
                          const Text('ลงทะเบียน'), // Thai text for 'Register'
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                        'มีบัญชีผู้ใช้อยู่แล้ว? เข้าสู่ระบบ'), // Thai text for 'Already have an account? Log in.'
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
