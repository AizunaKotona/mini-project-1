import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login_page.dart';
import 'usermodel.dart';
import 'database_helper.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key, required User user})
      : _user = ValueNotifier<User>(user),
        super(key: key);

  final ValueNotifier<User> _user;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  late User _userData;
  String _errorMessage = '';

  Future<void> _onUpdateButtonPressed(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final updatedUser = User(
        user_id: widget._user.value.user_id,
        username: widget._user.value.username,
        password: _passwordController.text.isNotEmpty
            ? _passwordController.text
            : widget._user.value.password,
        email: _emailController.text.isNotEmpty
            ? _emailController.text
            : widget._user.value.email,
        phone: _phoneController.text.isNotEmpty
            ? _phoneController.text
            : widget._user.value.phone,
        role: widget._user.value.role,
      );

      await DatabaseHelper.instance.updateUser(updatedUser.toMap());

      setState(() {
        widget._user.value = updatedUser;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profile updated successfully'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _onLogoutButtonPressed(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _passwordController.text = widget._user.value.password;
    _emailController.text = widget._user.value.email ?? '';
    _phoneController.text = widget._user.value.phone ?? '';

    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final dbHelper = DatabaseHelper.instance;
    final userData =
        await dbHelper.queryUserByUsername(widget._user.value.username);

    setState(() {
      _userData = User.fromMap(userData.first);
      _passwordController.text = _userData.password;
      _emailController.text = _userData.email ?? '';
      _phoneController.text = _userData.phone ?? '';
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<User>(
      valueListenable: widget._user,
      builder: (context, user, child) {
        return Scaffold(
          body: Stack(
            children: [
              // Container(
              //   decoration: const BoxDecoration(
              //     gradient: LinearGradient(
              //       colors: [Colors.blueGrey, Colors.white],
              //       begin: Alignment.topCenter,
              //       end: Alignment.bottomCenter,
              //     ),
              //   ),
              // ),
              SafeArea(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 16.0),
                    Text(
                      'ยินดีต้อนรับ, ${user.username}!', // Thai text for 'Welcome, {username}!'
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText:
                                      'รหัสผ่าน', // Thai text for 'Password'
                                ),
                                validator: (value) {
                                  if (value != null &&
                                      value.isNotEmpty &&
                                      value.length < 8) {
                                    return 'รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร'; // Thai text for 'Password must be at least 8 characters'
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'อีเมล', // Thai text for 'Email'
                                ),
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (!value.contains('@')) {
                                      return 'โปรดป้อนที่อยู่อีเมลที่ถูกต้อง'; // Thai text for 'Please enter a valid email address'
                                    }
                                    if (value.length > 50) {
                                      return 'ที่อยู่อีเมลยาวเกินไป'; // Thai text for 'Email address is too long'
                                    }
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                decoration: InputDecoration(
                                  labelText:
                                      'โทรศัพท์', // Thai text for 'Phone'
                                ),
                                validator: (value) {
                                  if (value != null && value.isNotEmpty) {
                                    if (value.length < 10) {
                                      return 'หมายเลขโทรศัพท์ต้องมีอย่างน้อย 10 หลัก'; // Thai text for 'Phone number must be at least 10 digits'
                                    }
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      _onUpdateButtonPressed(context),
                                  child: const Text(
                                      'อัพเดทโปรไฟล์'), // Thai text for 'Update Profile'
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                _errorMessage,
                                style: TextStyle(
                                  color: _errorMessage.isNotEmpty
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () =>
                                      _onLogoutButtonPressed(context),
                                  child: const Text(
                                      'ออกจากระบบ'), // Thai text for 'Log Out'
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
