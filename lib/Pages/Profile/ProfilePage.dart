import 'package:flutter/material.dart';
import '../Home/home.dart'; // Thay bằng đường dẫn đến HomePage
import '../Login/LoginPage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Trang Cá Nhân',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Điều hướng về HomePage
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false, // Xóa tất cả các route trước đó
            );
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Avatar và tên người dùng
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                    'assets/images/40x40.png',
                  ), // Thay bằng đường dẫn ảnh của bạn
                ),
                const SizedBox(height: 10),
                const Text(
                  'Nguyễn Văn A',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const Text(
                  'Học sinh lớp 12',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Danh sách chức năng
          _buildProfileOption(
            icon: Icons.book,
            title: 'Khóa học của tôi',
            color: Colors.orange,
            onTap: () {
              // Xử lý khi nhấn vào
            },
          ),
          _buildProfileOption(
            icon: Icons.bar_chart,
            title: 'Theo dõi học tập',
            color: Colors.green,
            onTap: () {
              // Xử lý khi nhấn vào
            },
          ),
          _buildProfileOption(
            icon: Icons.emoji_events,
            title: 'Thành tích',
            color: Colors.purple,
            onTap: () {
              // Xử lý khi nhấn vào
            },
          ),
          _buildProfileOption(
            icon: Icons.edit,
            title: 'Chỉnh sửa trang cá nhân',
            color: Colors.red,
            onTap: () {
              // Xử lý khi nhấn vào
            },
          ),
          _buildProfileOption(
            icon: Icons.settings,
            title: 'Cài đặt',
            color: Colors.blueGrey,
            onTap: () {
              // Xử lý khi nhấn vào
            },
          ),
          const Divider(),
          // Mục Đăng xuất
          _buildProfileOption(
            icon: Icons.logout,
            title: 'Đăng xuất',
            color: Colors.grey,
            onTap: () {
              // Điều hướng về màn hình LoginPage
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false, // Xóa tất cả các route trước đó
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
