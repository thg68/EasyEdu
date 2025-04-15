import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Từ Điển',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    SearchPage(),
    PlaceholderWidget('Từ đã lưu'),
    PlaceholderWidget('Cá nhân'),
    PlaceholderWidget('Cài đặt'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Từ đã lưu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Cá nhân',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Cài đặt',
          ),
        ],
      ),
    );
  }
}

// Màn hình chính
class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bộ Tìm Kiếm'),
        leading: Icon(Icons.arrow_back),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Ô tìm kiếm
            TextField(
              decoration: InputDecoration(
                hintText: 'Từ khóa...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Hai ô kết quả (giả lập)
            buildBox('Kết quả 1'),
            SizedBox(height: 10),
            buildBox('Kết quả 2'),
          ],
        ),
      ),
    );
  }

  Widget buildBox(String text) {
    return Container(
      width: double.infinity,
      height: 60,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text, style: TextStyle(fontSize: 16)),
    );
  }
}

// Placeholder cho các tab khác
class PlaceholderWidget extends StatelessWidget {
  final String title;
  const PlaceholderWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title, style: TextStyle(fontSize: 24)));
  }
}
