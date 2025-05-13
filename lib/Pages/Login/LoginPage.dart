import 'package:flutter/material.dart';
import '../../NavigationBar/NavigationBar.dart';
import '../Login/Register.dart';
import '../Login/forgot_pw.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF7FF), // Màu nền tím nhạt
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              // Hình ảnh minh họa
              Center(
                child: Image.asset(
                  'assets/images/education.png',
                  height: 200,
                ),
              ),
              const SizedBox(height: 30),
              // Tiêu đề
              Text(
                'Chào mừng đến với EasyEdu',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF9575CD), // Màu tím chủ đạo
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Vui lòng đăng nhập để cùng bước vào cuộc hành trình!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              // Ô nhập Email
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF9575CD)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF9575CD)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF9575CD), width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.email, color: Color(0xFF9575CD)),
                ),
              ),
              const SizedBox(height: 20),
              // Ô nhập Password
              TextField(
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  labelStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF9575CD)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF9575CD)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF9575CD), width: 2),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.lock, color: Color(0xFF9575CD)),
                  suffixIcon:
                      Icon(Icons.visibility_off, color: Color(0xFF9575CD)),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              // Quên mật khẩu
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPasswordPage()),
                    );
                  },
                  child: Text(
                    'Quên mật khẩu?',
                    style: TextStyle(color: Color(0xFF9575CD)), // Màu tím
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Nút Đăng nhập
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainNavigationScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF9575CD), // Màu tím chủ đạo
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              // Đăng ký tài khoản mới
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Chưa có tài khoản?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()),
                      );
                    },
                    child: Text(
                      'Đăng ký',
                      style: TextStyle(color: Color(0xFF9575CD)), // Màu tím
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
