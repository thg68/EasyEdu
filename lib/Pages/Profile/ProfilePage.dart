import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../Home/home.dart'; // Thay bằng đường dẫn đến HomePage
import '../Login/LoginPage.dart';
import 'EditProfile.dart'; // Import trang EditProfilePage
import 'Setting.dart';
import 'AchievementProfile.dart';
import 'TrackLearning.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = "Nguyễn Văn A"; // Tên mặc định
  String _className = "Học sinh lớp 12"; // Lớp mặc định
  File? _avatarImage; // Ảnh đại diện mặc định (null)

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
              MaterialPageRoute(builder: (context) => const HomePage()),
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
                GestureDetector(
                  onTap: _pickImage, // Chọn ảnh khi nhấn vào avatar
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: _avatarImage != null
                        ? FileImage(_avatarImage!) as ImageProvider
                        : const AssetImage('assets/images/profile_icon.png'),
                    child: _avatarImage == null
                        ? const Icon(
                            Icons.camera_alt,
                            size: 30,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  _className,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Danh sách chức năng
          // _buildProfileOption(
          //   icon: Icons.book,
          //   title: 'Khóa học của tôi',
          //   color: Colors.orange,
          //   onTap: () {
          //     // Xử lý khi nhấn vào
          //   },
          // ),
          _buildProfileOption(
            icon: Icons.bar_chart,
            title: 'Theo dõi học tập',
            color: Colors.green,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrackLearning()),
              );
            },
          ),
          _buildProfileOption(
            icon: Icons.emoji_events,
            title: 'Thành tích',
            color: Colors.purple,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AchievementProfile()),
              );
            },
          ),
          _buildProfileOption(
            icon: Icons.edit,
            title: 'Chỉnh sửa trang cá nhân',
            color: Colors.red,
            onTap: () {
              // Điều hướng đến EditProfilePage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(
                    name: _name,
                    className: _className,
                    // Truyền avatar hiện tại sang EditProfile
                    avatarUrl: _avatarImage?.path,
                  ),
                ),
              ).then((result) {
                // Cập nhật thông tin nếu có dữ liệu trả về
                if (result != null && result is Map<String, dynamic>) {
                  setState(() {
                    _name = result['name'] ?? _name;
                    _className = result['className'] ?? _className;
                    // Cập nhật avatarFile thay vì avatar
                    _avatarImage = result['avatarFile'] ?? _avatarImage;
                  });
                }
              });
            },
          ),
          _buildProfileOption(
            icon: Icons.settings,
            title: 'Cài đặt',
            color: Colors.blueGrey,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
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
          backgroundColor: color.withOpacity(0.2),
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

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _avatarImage = File(pickedFile.path);
      });
    }
  }
}
