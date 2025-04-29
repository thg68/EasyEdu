import 'package:flutter/material.dart';
import '../DetailPages/DetailPage.dart'; // Import DetailPage

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Phần header cố định
            _buildHeaderSection(context),

            // Phần nội dung có thể scroll
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildSubjectsHeader(),
                    _buildSubjectsGrid(),
                    const SizedBox(height: 20), // Thêm khoảng trống phía dưới
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Column(
      children: [
        // App Bar
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: const Text(
            'Trang Chủ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Thông tin học sinh
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          color: const Color(0xFFFEF7FF),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStudentProfile(),
              _buildGradeInfo('Điểm Số', 'A+'),
              _buildGradeInfo('GPA', '3.7'),
            ],
          ),
        ),

        // Divider
        _buildDivider(),

        // Lịch học
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          color: const Color(0xFFFEF7FF),
          child: _buildCalendar(),
        ),

        // Divider
        _buildDivider(),

        // Môn học tiếp theo
        _buildNextClassInfo(),

        // Divider
        _buildDivider(),
      ],
    );
  }

  Widget _buildStudentProfile() {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/40x40.png'),
              fit: BoxFit.cover,
            ),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Nguyễn Văn A',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildGradeInfo(String title, String value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFFCAC4D0),
    );
  }

  Widget _buildCalendar() {
    return Column(
      children: [
        // Ngày trong tuần
        SizedBox(
          height: 40,
          child: Row(
            children: ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'].map((day) {
              return Expanded(
                child: Center(
                  child: Text(
                    day,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // Ngày trong tháng
        SizedBox(
          height: 40,
          child: Row(
            children: List.generate(7, (index) {
              final day = index + 7;
              final isSelected = day == 11;
              return Expanded(
                child: Center(
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF65558F) : null,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$day',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: isSelected ? 14 : 16,
                          fontWeight:
                              isSelected ? FontWeight.w500 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildNextClassInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Môn học Tiếp theo',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF65558F)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // Thời gian và phòng học
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('09:00 - 10:00'),
                    SizedBox(height: 8),
                    Text('P207 - B2'),
                  ],
                ),

                // Divider
                const VerticalDivider(width: 20, thickness: 1),

                // Môn học và giáo viên
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Môn: Vật lý'),
                      const SizedBox(height: 8),
                      const Text('Thầy Hữu Thế B'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectsHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      alignment: Alignment.centerLeft,
      child: const Text(
        'Môn học của tôi',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSubjectsGrid() {
    final subjects = [
      {'name': 'Đại số', 'icon': 'assets/images/Algebra_icon.png'},
      {'name': 'Giải tích', 'icon': 'assets/images/Geometry_icon.png'},
      {'name': 'Ngữ văn', 'icon': 'assets/images/Literature_icon.png'},
      {'name': 'Tiếng Anh', 'icon': 'assets/images/Spanish_icon.png'},
      {'name': 'Vật lý', 'icon': 'assets/images/Physics_icon.png'},
      {'name': 'Hóa học', 'icon': 'assets/images/Chemistry_icon.png'},
      {'name': 'Sinh học', 'icon': 'assets/images/Biology_icon.png'},
      {'name': 'Lịch sử', 'icon': 'assets/images/History_icon.png'},
      {'name': 'Địa lý', 'icon': 'assets/images/Geography_icon.png'},
      {'name': 'Giáo dục công dân', 'icon': 'assets/images/Civics_icon.png'},
      {'name': 'Tin học', 'icon': 'assets/images/Computer_Science_icon.png'},
      {'name': 'Công nghệ', 'icon': 'assets/images/Technology_icon.png'},
      {
        'name': 'Giáo dục thể chất',
        'icon': 'assets/images/Physical_Education_icon.png'
      },
      {
        'name': 'Kinh tế và Pháp luật',
        'icon': 'assets/images/Economics_icon.png'
      },
      {'name': 'Mỹ thuật', 'icon': 'assets/images/Arts_icon.png'},
      {'name': 'Âm nhạc', 'icon': 'assets/images/Music_icon.png'},
      {'name': 'Tư duy phản biện', 'icon': 'assets/images/Drama_icon.png'},
      {
        'name': 'Trải nghiệm, hướng nghiệp',
        'icon': 'assets/images/Career_icon.png'
      },
      {
        'name': 'Giáo dục quốc phòng',
        'icon': 'assets/images/Military_icon.png'
      },
      {
        'name': 'Giáo dục đặc biệt',
        'icon': 'assets/images/Special_Education_icon.png'
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.9,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return _buildSubjectItem(
              context,
              subjects[index]['name']!,
              subjects[index]['icon']!);
        },
      ),
    );
  }

  Widget _buildSubjectItem(BuildContext context, String name, String iconPath) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(title: name)),
        );
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(iconPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}