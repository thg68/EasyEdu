import 'package:flutter/material.dart';
import 'Pages/Home/home.dart'; // Import trang Home
import 'Pages/Search/search.dart'; // Import trang Search
//import 'Pages/Notification/notification.dart'; // Import trang Notification
//import 'Pages/Profile/profile.dart'; // Import trang Profile

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 254, 247, 255),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

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
    //const NotificationPage(),
    //const ProfilePage(),
    PlaceholderWidget("Thông Báo"),
    PlaceholderWidget("Hồ Sơ"),
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
        // Trang chủ
        NavigationDestination(
          icon: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home_icon.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          label: 'Trang Chủ',
          selectedIcon: Container(
            padding: const EdgeInsets.all(4),
            decoration: ShapeDecoration(
              color: const Color(0xFFE8DEF8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/home_icon.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        // Tìm kiếm
        NavigationDestination(
          icon: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/search_icon.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          label: 'Tìm Kiếm',
          selectedIcon: Container(
            padding: const EdgeInsets.all(4),
            decoration: ShapeDecoration(
              color: const Color(0xFFE8DEF8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/search_icon.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        // Thông báo
        NavigationDestination(
          icon: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/notification_icon.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          label: 'Thông Báo',
          selectedIcon: Container(
            padding: const EdgeInsets.all(4),
            decoration: ShapeDecoration(
              color: const Color(0xFFE8DEF8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/notification_icon.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        // Hồ sơ
        NavigationDestination(
          icon: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile_icon.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          label: 'Hồ Sơ',
          selectedIcon: Container(
            padding: const EdgeInsets.all(4),
            decoration: ShapeDecoration(
              color: const Color(0xFFE8DEF8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/profile_icon.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String title;

  const PlaceholderWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
