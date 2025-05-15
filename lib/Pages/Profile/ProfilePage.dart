import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Home/home.dart';
import '../Login/LoginPage.dart';
import 'EditProfile.dart';
import 'Setting.dart';
import 'AchievementProfile.dart';
import 'TrackLearning.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = "Nguyễn Văn A";
  String _class = "Lớp 12";
  File? _avatarImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('userName') ?? "Nguyễn Văn A";
      _class = prefs.getString('userClass') ?? "Lớp 12";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9575CD), // Màu tím chủ đạo
        title: const Text(
          'Trang Cá Nhân',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
              (route) => false,
            );
          },
        ),
      ),
      body: Container(
        color: const Color(0xFFFEF7FF), // Màu nền tím nhạt
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor:
                          const Color(0xFF9575CD).withValues(alpha: 0.1),
                      backgroundImage: _avatarImage != null
                          ? FileImage(_avatarImage!) as ImageProvider
                          : const AssetImage('assets/images/40x40.png'),
                      child: _avatarImage == null
                          ? Icon(
                              Icons.camera_alt,
                              size: 30,
                              color: Color(0xFF9575CD).withValues(alpha: 0.8),
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
                      color: Color(0xFF9575CD), // Màu tím chủ đạo
                    ),
                  ),
                  Text(
                    _class,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileOption(
              icon: Icons.bar_chart,
              title: 'Theo dõi học tập',
              color: const Color(0xFF9575CD), // Màu tím chủ đạo
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
              color: const Color(0xFF9575CD), // Màu tím chủ đạo
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
              color: const Color(0xFF9575CD), // Màu tím chủ đạo
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      name: _name,
                      userClass: _class,
                      avatarUrl: _avatarImage?.path,
                    ),
                  ),
                );

                if (result != null && result is Map<String, dynamic>) {
                  setState(() {
                    _name = result['name'] ?? _name;
                    _class = result['userClass'] ?? _class;
                    _avatarImage = result['avatarFile'] ?? _avatarImage;
                  });

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('userName', _name);
                  await prefs.setString('userClass', _class);
                }
              },
            ),
            _buildProfileOption(
              icon: Icons.settings,
              title: 'Cài đặt',
              color: const Color(0xFF9575CD), // Màu tím chủ đạo
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
            const Divider(color: Color(0xFFCAC4D0)), // Màu divider xám nhạt
            _buildProfileOption(
              icon: Icons.logout,
              title: 'Đăng xuất',
              color: Colors.grey,
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('userName');
                await prefs.remove('userClass');
                await prefs.remove('isLoggedIn');

                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
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
      color: Colors.white,
      // Nền trắng cho card
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
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
