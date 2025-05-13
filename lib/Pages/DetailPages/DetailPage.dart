import 'package:flutter/material.dart';
import 'LessonPage.dart';
import '../TeacherPages/createlesson.dart';

class DetailPage extends StatelessWidget {
  final String title;

  const DetailPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F4FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateLessonPage()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(Icons.add, color: Colors.purple, size: 24),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Phần quá trình học cố định
            _buildStatusInfoSection(),

            // Phần nội dung có thể scroll
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildLessonSection(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusInfoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatusInfoItem(Icons.hourglass_empty, 'Chưa học', Colors.grey),
        _buildStatusInfoItem(Icons.hourglass_top, 'Đang học', Colors.blue),
        _buildStatusInfoItem(Icons.check_circle, 'Đã học', Colors.green),
        _buildStatusInfoItem(Icons.quiz, 'Bài kiểm tra', Colors.orange)
      ],
    );
  }

  Widget _buildStatusInfoItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildLessonSection() {
    final lessons = [
      {'name': 'Bài 1: Hàm số', 'status': 'Chưa học'},
      {'name': 'Bài 2: Giới hạn hàm số', 'status': 'Đang học'},
      {'name': 'Bài kiểm tra số 1', 'status': 'Bài kiểm tra'},
      {'name': 'Bài 3: Vô cùng lớn, vô cùng bé', 'status': 'Đã học'},
      {'name': 'Bài 4: Đạo hàm vi phân', 'status': 'Chưa học'},
      {'name': 'Bài kiểm tra số 2', 'status': 'Bài kiểm tra'},
      {'name': 'Bài 5: Khảo sát hàm số', 'status': 'Đã học'},
      {'name': 'Bài 6: Tích phân', 'status': 'Chưa học'},
      {
        'name': 'Bài 7: Định lý cơ bản của phép tính tích phân',
        'status': 'Đã học'
      },
      {'name': 'Bài kiểm tra số 3', 'status': 'Bài kiểm tra'},
      {'name': 'Bài 8: Tích phân xác định', 'status': 'Chưa học'},
      {'name': 'Bài 9: Tích phân bất định', 'status': 'Đã học'},
      {'name': 'Bài kiểm tra số 4', 'status': 'Bài kiểm tra'}
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: lessons.length,
          separatorBuilder: (context, index) => SizedBox(height: 16),
          itemBuilder: (context, index) {
            return buildLessonItem(
                context, lessons[index]['name']!, lessons[index]['status']!);
          },
        ),
      ],
    );
  }

  Widget buildLessonItem(BuildContext context, String title, String status) {
    IconData statusIcon;
    Color statusColor;

    switch (status) {
      case 'Chưa học':
        statusIcon = Icons.hourglass_empty;
        statusColor = Colors.grey;
      case 'Đang học':
        statusIcon = Icons.hourglass_top;
        statusColor = Colors.blue;
      case 'Đã học':
        statusIcon = Icons.check_circle;
        statusColor = Colors.green;
      case 'Bài kiểm tra':
        statusIcon = Icons.quiz;
        statusColor = Colors.orange;
      default:
        statusIcon = Icons.help_outline;
        statusColor = Colors.black;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LessonPage(title: title)),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.purple.shade100, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(statusIcon, color: statusColor),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
