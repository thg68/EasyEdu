import 'package:flutter/material.dart';

void main() {
  runApp(const EducationSpApp());
}

class EducationSpApp extends StatelessWidget {
  const EducationSpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 254, 247, 255),
      ),
      home: const ExamplesDetailedViewMobile(),
    );
  }
}

class ExamplesDetailedViewMobile extends StatefulWidget {
  const ExamplesDetailedViewMobile({super.key});

  @override
  State<ExamplesDetailedViewMobile> createState() =>
      _ExamplesDetailedViewMobileState();
}

class _ExamplesDetailedViewMobileState
    extends State<ExamplesDetailedViewMobile> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        backgroundColor: const Color(0xFFF3EDF7),
        destinations: [
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
          ),
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
          ),
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
          ),
        ],
      ),
      body:
          <Widget>[
            buildHomePage(),
            buildSearchPage(),
            buildNotificationPage(),
            buildProfilePage(),
          ][currentPageIndex],
    );
  }

  Widget buildHomePage() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top:50),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            height: 25,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 175,
                  child: Text(
                    'Trang Chủ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 1,
                      letterSpacing: 0.20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Student Profile Section
          Container(
            width: double.infinity,
            height: 110,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            color: const Color(0xFFFEF7FF),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Student Profile
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/40x40.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 100,
                        child: Text(
                          'Nguyễn Văn A',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 1.43,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Letter Grade
                const SizedBox(
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 22.22,
                        child: Text(
                          'Điểm Số',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 1.43,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 22.22,
                        child: Text(
                          'A+',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 1.27,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // GPA
                const SizedBox(
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 22.22,
                        child: Text(
                          'GPA',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 1.43,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 22.22,
                        child: Text(
                          '3.7\n',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 1.27,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Horizontal Divider
          Container(
            width: double.infinity,
            height: 1,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFCAC4D0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Calendar Section
          Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFFEF7FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Calendar Days
                buildCalendarDays(),
              ],
            ),
          ),

          // Horizontal Divider
          Container(
            width: double.infinity,
            height: 1,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFCAC4D0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Next Subject Text
          Container(
            width: double.infinity,
            height: 136,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [buildNextSubject()],
            ),
          ),

          // Horizontal Divider
          Container(
            width: double.infinity,
            height: 1,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignCenter,
                        color: Color(0xFFCAC4D0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // My Subject Text
          Container(
            width: double.infinity,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                SizedBox(
                  width: 325,
                  child: Text(
                    'Môn học của tôi',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      height: 1.43,
                      letterSpacing: 0.10,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // My Subjects
          Container(
            width: double.infinity,
            height: 1250,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.start,
              runSpacing: 10,
              children: [
                // My Subjects
                buildMySubjects()],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCalendarDays() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Days of the week
          SizedBox(
            width: double.infinity,
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var day in ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'])
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            day,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF1D1B20),
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                              letterSpacing: 0.50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Calendar numbers
          SizedBox(
            width: double.infinity,
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Days 7-10 normal style
                for (var day in ['7', '8', '9', '10'])
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  day,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF1D1B20),
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 1.50,
                                    letterSpacing: 0.50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Day 11 selected style
                Expanded(
                  child: SizedBox(
                    height: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF65558F),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                '11',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  height: 1.43,
                                  letterSpacing: 0.10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Days 12-13 normal style
                for (var day in ['12', '13'])
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  day,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF1D1B20),
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 1.50,
                                    letterSpacing: 0.50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNextSubject() {
    return Container(
      width: 400,
      height: 116,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 340,
            height: 25,
            child: Text(
              'Môn học Tiếp theo',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 1.43,
                letterSpacing: 0.10,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: const Color(0xFF65558F)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left section - Time and Room
                  SizedBox(
                    width: 100,
                    height: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 15,
                          child: Text(
                            '09:00 - 10:00',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 1.43,
                              letterSpacing: 0.10,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 100,
                          height: 15,
                          child: Text(
                            'P207 - B2',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              height: 1.43,
                              letterSpacing: 0.10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Vertical Divider
                  const VerticalDivider(
                    width: 20,
                    thickness: 1,
                    color: Color(0xFFCAC4D0),
                    indent: 10,
                    endIndent: 10,
                  ),

                  // Right section - Subject and Teacher
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 179,
                            height: 15,
                            child: Text(
                              'Môn: Vật lý',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 1.43,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: 179,
                            height: 15,
                            child: Text(
                              'Thầy Hữu Thế B',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                height: 1.43,
                                letterSpacing: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMySubjects() {
    return Container(
      width: double.infinity,
      height: 1250,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.start,
        runSpacing: 10,
        children: [
          //Number of subjects: 20
          singleSubject('Đại số', 'assets/images/Algebra_icon.png'),
          singleSubject('Giải tích', 'assets/images/Geometry_icon.png'),
          singleSubject('Ngữ văn', 'assets/images/Literature_icon.png'),
          singleSubject('Tiếng Anh', 'assets/images/Spanish_icon.png'),
          singleSubject('Vật lý', 'assets/images/Physics_icon.png'),
          singleSubject('Hóa học', 'assets/images/Chemistry_icon.png'),
          singleSubject('Sinh học', 'assets/images/Biology_icon.png'),
          singleSubject('Lịch sử', 'assets/images/History_icon.png'),
          singleSubject('Địa lý', 'assets/images/Geography_icon.png'),
          singleSubject('Giáo dục công dân', 'assets/images/Civics_icon.png'),
          singleSubject('Tin học', 'assets/images/Computer_Science_icon.png'),
          singleSubject('Công nghệ', 'assets/images/Technology_icon.png'),
          singleSubject('Giáo dục thể chất', 'assets/images/Physical_Education_icon.png'),
          singleSubject('Kinh tế và Pháp luật', 'assets/images/Economics_icon.png'),
          singleSubject('Mỹ thuật', 'assets/images/Arts_icon.png'),
          singleSubject('Âm nhạc', 'assets/images/Music_icon.png'),
          singleSubject('Tư duy phản biện', 'assets/images/Drama_icon.png'),
          singleSubject('Trải nghiệm, hướng nghiệp', 'assets/images/Career_icon.png'),
          singleSubject('Giáo dục quốc phòng', 'assets/images/Military_icon.png'),
          singleSubject('Giáo dục đặc biệt', 'assets/images/Special_Education_icon.png'),
        ],
      ),
    );
  }

  Widget singleSubject(String subjectName,String assetLocation) {
    return SizedBox(
      width: 90,
      height: 120,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 5,
        children: [
          Container(
            width: 60,
            height: 60,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(assetLocation),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 90,
            child: Text(
              subjectName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 1.43,
                letterSpacing: 0.10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchPage() {
    return const Center(
      child: Text(
        'Trang tìm kiếm',
        style: TextStyle(color: Colors.black, fontSize: 24),
      ),
    );
  }

  Widget buildNotificationPage() {
    return const Padding(
      padding: EdgeInsets.only(left: 10, top: 50, right: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.notifications_sharp),
              title: Text('Thông báo 1'),
              subtitle: Text('Đây là một cái thông báo'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.notifications_sharp),
              title: Text('Thông báo 2'),
              subtitle: Text('Đây cũng là một cái thông báo'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfilePage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/40x40.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Nguyễn Văn A',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Học sinh',
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
