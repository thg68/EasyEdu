import 'package:easy_edu/Pages/Notif/notification.dart';
import 'package:flutter/material.dart';
import '../Pages/Home/home.dart';
import '../Pages/Search/search.dart';
import '../Pages/Profile/profilePage.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentPageIndex = 0;

  // Danh sách các trang tương ứng với mỗi tab
  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    NotificationPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  NavigationBar _buildNavigationBar() {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          _currentPageIndex = index;
        });
      },
      selectedIndex: _currentPageIndex,
      backgroundColor: const Color(0xFFF3EDF7),
      destinations: [
        _buildNavigationDestination(
          iconPath: 'assets/images/home_icon.png',
          label: 'Trang Chủ',
        ),
        _buildNavigationDestination(
          iconPath: 'assets/images/search_icon.png',
          label: 'Tìm Kiếm',
        ),
        _buildNavigationDestination(
          iconPath: 'assets/images/notification_icon.png',
          label: 'Thông Báo',
        ),
        _buildNavigationDestination(
          iconPath: 'assets/images/profile_icon.png',
          label: 'Hồ Sơ',
        ),
      ],
    );
  }

  NavigationDestination _buildNavigationDestination({
    required String iconPath,
    required String label,
  }) {
    return NavigationDestination(
      icon: _buildIcon(iconPath),
      label: label,
      selectedIcon: _buildSelectedIcon(iconPath),
    );
  }

  Widget _buildIcon(String iconPath) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(iconPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSelectedIcon(String iconPath) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        color: const Color(0xFFE8DEF8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: _buildIcon(iconPath),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String title;

  const PlaceholderWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
