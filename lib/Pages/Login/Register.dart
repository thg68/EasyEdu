import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../NavigationBar/NavigationBar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? _selectedClass;

  // Danh sách các lớp học
  final List<String> _classes = [
    'Lớp 1',
    'Lớp 2',
    'Lớp 3',
    'Lớp 4',
    'Lớp 5',
    'Lớp 6',
    'Lớp 7',
    'Lớp 8',
    'Lớp 9',
    'Lớp 10',
    'Lớp 11',
    'Lớp 12',
    'Đại học',
  ];

  Future<void> _register() async {
    final name = nameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        _selectedClass == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng điền đầy đủ thông tin')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', name);
    await prefs.setString('userEmail', email);
    await prefs.setString('userClass', _selectedClass!);
    await prefs.setBool('isLoggedIn', true);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainNavigationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Create Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Text(
              'Create a New Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[100],
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[100],
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[100],
                prefixIcon: const Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 20),
            // Dropdown để chọn lớp học
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
                color: Colors.grey[100],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text('Chọn lớp học'),
                  value: _selectedClass,
                  items: _classes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedClass = newValue;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _register,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('REGISTER',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
