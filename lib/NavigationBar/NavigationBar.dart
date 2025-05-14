import 'package:easy_edu/Pages/Notif/notification.dart';
import 'package:flutter/material.dart';
import '../Pages/Home/home.dart';
import '../Pages/Search/search.dart';
import '../Pages/Profile/profilePage.dart';
import 'package:provider/provider.dart';
import '../Pages/Profile/ThemeProvider.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentPageIndex = 0;

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

  Widget _buildNavigationBar() {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          selectedIndex: _currentPageIndex,
          backgroundColor: themeProvider.highContrast
              ? Colors.black
              : const Color(0xFFF3EDF7),
          height: 65 * (themeProvider.fontSize / 16),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          indicatorColor: themeProvider.highContrast
              ? Colors.white.withValues(alpha: 0.1)
              : const Color(0xFFE8DEF8),
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
      },
    );
  }

  Widget _buildNavigationDestination({
    required String iconPath,
    required String label,
  }) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return NavigationDestination(
          icon: _buildIcon(iconPath, themeProvider),
          label: label,
          selectedIcon: _buildSelectedIcon(iconPath, themeProvider),
        );
      },
    );
  }

  Widget _buildIcon(String iconPath, ThemeProvider themeProvider) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double size = 24 * (themeProvider.fontSize / 16);
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(iconPath),
              fit: BoxFit.contain,
              colorFilter: themeProvider.highContrast
                  ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : null,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSelectedIcon(String iconPath, ThemeProvider themeProvider) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double padding = 4 * (themeProvider.fontSize / 16);
        return Container(
          padding: EdgeInsets.all(padding),
          decoration: ShapeDecoration(
            color: themeProvider.highContrast
                ? Colors.white.withValues(alpha: 0.1)
                : const Color(0xFFE8DEF8),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(16 * (themeProvider.fontSize / 16)),
            ),
          ),
          child: _buildIcon(iconPath, themeProvider),
        );
      },
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String title;

  const PlaceholderWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24 * (themeProvider.fontSize / 16),
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
