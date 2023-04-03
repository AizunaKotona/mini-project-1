import 'package:flutter/material.dart';
import 'usermodel.dart';
import 'database_helper.dart';

class ManageUserPage extends StatefulWidget {
  const ManageUserPage({Key? key}) : super(key: key);

  @override
  _ManageUserPageState createState() => _ManageUserPageState();
}

class _ManageUserPageState extends State<ManageUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _roleController = TextEditingController();
  String _errorMessage = '';

  List<User> _users = []; // Change this line

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final users = await DatabaseHelper.instance.queryAllUsers();
    setState(() {
      _users = users
          .map((map) => User.fromMap(map))
          .toList(); // Map the maps to User objects
    });
  }

  Future<void> _onSaveButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        username: _usernameController.text,
        password: _passwordController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        role: _roleController.text,
      );

      await DatabaseHelper.instance.insertUser(user);
      setState(() {
        _errorMessage = 'User saved successfully';
      });
      _fetchUsers();
      _usernameController.text = '';
      _passwordController.text = '';
      _emailController.text = '';
      _phoneController.text = '';
      _roleController.text = '';
    }
  }

  Future<void> _onDeleteButtonPressed(int id) async {
    await DatabaseHelper.instance.deleteUser(id);
    setState(() {
      _errorMessage = 'User deleted successfully';
    });
    _fetchUsers();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (!value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      if (value.length > 50) {
                        return 'Email must not exceed 50 characters';
                      }
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (value.length > 20) {
                        return 'Phone number must not exceed 20 characters';
                      }
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _roleController,
                  decoration: const InputDecoration(
                    labelText: 'Role',
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (value != 'admin' && value != 'user') {
                        return 'Role must be either "admin" or "user"';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _onSaveButtonPressed,
                  child: const Text('Save'),
                ),
                const SizedBox(height: 16.0),
                Text(
                  _errorMessage,
                  style: TextStyle(
                    color:
                        _errorMessage.isEmpty ? Colors.transparent : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Text(
            'Users',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 8.0),
          if (_users.isEmpty)
            const Center(child: Text('No users found.'))
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return Card(
                  child: ListTile(
                    title: Text(user.username),
                    subtitle: Text(user.email ?? 'No email available'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _onDeleteButtonPressed(user.user_id!),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
