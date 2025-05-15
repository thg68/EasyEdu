import 'package:flutter/material.dart';
import 'LessonPage.dart';
import 'ExamPage.dart';
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
      {'name': 'Bài 1: Hàm số', 'status': 'Đã học'},
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

    final algebraLessons = [
      {'name': 'Bài 1: Hàm số và các bài toán liên quan', 'status': 'Đã học'},
      {
        'name': 'Bài 2: Hàm số lũy thừa, hàm số mũ và hàm số logarit',
        'status': 'Đã học'
      },
      {
        'name': 'Bài 3: Phương trình mũ và phương trình logarit',
        'status': 'Đang học'
      },
      {
        'name': 'Bài 4: Bất phương trình mũ và bất phương trình logarit',
        'status': 'Chưa học'
      },
      {
        'name': 'Bài 5: Ứng dụng đạo hàm để khảo sát và vẽ đồ thị hàm số',
        'status': 'Đang học'
      },
      {
        'name': 'Bài 6: Giá trị lớn nhất và nhỏ nhất của hàm số',
        'status': 'Đang học'
      },
      {'name': 'Bài 7: Khối đa diện', 'status': 'Đã học'},
      {'name': 'Bài 8: Thể tích của khối đa diện', 'status': 'Đang học'},
      {'name': 'Bài 9: Mặt cầu, mặt trụ, mặt nón', 'status': 'Đã học'},
      {'name': 'Bài kiểm tra số 1', 'status': 'Bài kiểm tra'},
      {'name': 'Bài 10: Tổ hợp và xác suất', 'status': 'Chưa học'},
      {'name': 'Bài 11: Nhị thức Newton', 'status': 'Đã học'},
      {'name': 'Bài 12: Số phức', 'status': 'Đã học'},
      {'name': 'Bài kiểm tra số 2', 'status': 'Bài kiểm tra'},
      {'name': 'Bài 13: Ôn tập học kỳ I', 'status': 'Đã học'},
      {'name': 'Bài kiểm tra học kỳ I', 'status': 'Bài kiểm tra'},
      {'name': 'Bài 14: Khái niệm về nguyên hàm', 'status': 'Đang học'},
      {'name': 'Bài 15: Tích phân và ứng dụng', 'status': 'Chưa học'},
      {'name': 'Bài 16: Số phức (phần nâng cao)', 'status': 'Chưa học'},
      {'name': 'Bài kiểm tra số 3', 'status': 'Bài kiểm tra'},
      {'name': 'Bài 17: Ôn tập cuối năm', 'status': 'Chưa học'},
      {'name': 'Bài kiểm tra học kỳ II', 'status': 'Bài kiểm tra'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: title == 'Đại Số' ? algebraLessons.length : lessons.length,
          separatorBuilder: (context, index) => SizedBox(height: 16),
          itemBuilder: (context, index) {
            if (title == 'Đại Số') {
              return buildLessonItem(context, algebraLessons[index]['name']!,
                  algebraLessons[index]['status']!);
            }
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
        if (status == 'Bài kiểm tra') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ExamPage(title: title)),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LessonPage(title: title)),
          );
        }
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
