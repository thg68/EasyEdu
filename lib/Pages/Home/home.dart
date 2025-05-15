import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart'
    show
        CalendarFormat,
        CalendarStyle,
        RangeSelectionMode,
        StartingDayOfWeek,
        TableCalendar,
        isSameDay;

import '../../Utils/event.dart';
import '../TeacherPages/createlesson.dart';
import '../DetailPages/DetailPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late final ValueNotifier<List<Event>> _selectedEvents;
  final double subjectGridSize = 68; //scale at 60-110, 80 looks best

  @override
  void initState() {
    super.initState();
    initCalendarEvents();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [for (final d in days) ..._getEventsForDay(d)];
  }

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
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 2),
          child: const Text(
            'Trang Chủ',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),

        // Thông tin học sinh
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
          color: const Color(0xFFFEF7FF),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStudentProfile(),
              _buildGradeInfo('Điểm Số', 'A+'),
              _tempCreateLesson('GPA', '3.7'),
            ],
          ),
        ),

        // Divider
        _buildHDivider(),

        // Lịch học
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

        // Divider
        _buildHDivider(),

        // Môn học tiếp theo
        Container(
          width: double.infinity,
          height: 136,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [buildEventDisplay()],
          ),
        ),

        // Divider
        _buildHDivider(),
      ],
    );
  }

  Widget _buildStudentProfile() {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final prefs = snapshot.data as SharedPreferences;
          final userName = prefs.getString('userName') ??
              'Nguyễn Văn A'; // Giá trị mặc định nếu chưa có

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
              Text(
                userName, // Sử dụng tên từ SharedPreferences
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          );
        }
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
              'Đang tải...',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
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

  Widget _buildHDivider() {
    return Container(
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
    );
  }

  Widget buildCalendarDays() {
    return TableCalendar(
      firstDay: kFirstDay,
      lastDay: kLastDay,
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      rangeStartDay: _rangeStart,
      rangeEndDay: _rangeEnd,
      calendarFormat: _calendarFormat,
      rangeSelectionMode: _rangeSelectionMode,
      eventLoader: _getEventsForDay,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: false,
        markerSize: 6,
      ),
      onDaySelected: _onDaySelected,
      onRangeSelected: _onRangeSelected,
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }

  /*Widget buildNextSubject() {
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
              'Next Subject',
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
                            'R207 - B2',
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

                  const VerticalDivider(
                    width: 20,
                    thickness: 1,
                    color: Color(0xFFCAC4D0),
                    indent: 10,
                    endIndent: 10,
                  ),

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
                              'Subject: Physics',
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
                              'Mr. John Smith',
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
  }*/

  Widget buildEventDisplay() {
    return ValueListenableBuilder<List<Event>>(
      valueListenable: _selectedEvents,
      builder: (context, events, _) {
        if (events.isEmpty) {
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
                    'Không có môn học trong ngày này.',
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
                  child: Center(
                    child: Text(
                      'Chọn ngày có sự kiện.',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final event = events[0];

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      events.length > 1
                          ? 'Môn học tiếp theo (${events.length} môn)'
                          : 'Môn học tiếp theo',
                      style: TextStyle(
                        color: Colors.black,
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
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: const Color(0xFF65558F),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Left section: Time and Room
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
                              height: 20,
                              child: Text(
                                event.timeRange.isNotEmpty
                                    ? event.timeRange
                                    : 'Chưa có thời gian cụ thể',
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
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 100,
                              height: 20,
                              child: Text(
                                event.location.isNotEmpty
                                    ? event.location
                                    : 'Chưa có phòng cụ thể',
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

                      // Vertical Divider
                      const VerticalDivider(
                        width: 30,
                        thickness: 1,
                        color: Color(0xFFCAC4D0),
                        indent: 10,
                        endIndent: 10,
                      ),

                      // Right section: Subject and Teacher
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
                                height: 20,
                                child: Text(
                                  event.subject != null
                                      ? 'Môn: ${event.subject}'
                                      : event.title,
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
                              const SizedBox(height: 6),
                              SizedBox(
                                width: 179,
                                height: 20,
                                child: Text(
                                  event.teacher != null
                                      ? event.teacher!
                                      : (events.length > 1
                                          ? 'Còn nhiều sự kiện khác'
                                          : ''),
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
      },
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
    final defaultSubjects = [
      {'name': 'Đại Số', 'icon': 'assets/images/Algebra_icon.png'},
      {'name': 'Giải Tích', 'icon': 'assets/images/Geometry_icon.png'},
      {'name': 'Ngữ Văn', 'icon': 'assets/images/Literature_icon.png'},
      {'name': 'Tiếng Anh', 'icon': 'assets/images/Spanish_icon.png'},
      {'name': 'Vật Lý', 'icon': 'assets/images/Physics_icon.png'},
      {'name': 'Hóa Học', 'icon': 'assets/images/Chemistry_icon.png'},
      {'name': 'Sinh Học', 'icon': 'assets/images/Biology_icon.png'},
      {'name': 'Lịch Sử', 'icon': 'assets/images/History_icon.png'},
      {'name': 'Địa Lý', 'icon': 'assets/images/Geography_icon.png'},
      {'name': 'Giáo Dục Công Dân', 'icon': 'assets/images/Civics_icon.png'},
      {'name': 'Tin Học', 'icon': 'assets/images/Computer_Science_icon.png'},
      {'name': 'Công Nghệ', 'icon': 'assets/images/Technology_icon.png'},
      {
        'name': 'Giáo Dục Thể Chất',
        'icon': 'assets/images/Physical_Education_icon.png'
      },
      {
        'name': 'Kinh Tế và Pháp Luật',
        'icon': 'assets/images/Economics_icon.png'
      },
      {'name': 'Mỹ Thuật', 'icon': 'assets/images/Arts_icon.png'},
      {'name': 'Âm Nhạc', 'icon': 'assets/images/Music_icon.png'},
      {'name': 'Tư Duy Phản Biện', 'icon': 'assets/images/Drama_icon.png'},
      {
        'name': 'Trải Nghiệm Hướng Việc',
        'icon': 'assets/images/Career_icon.png'
      },
      {
        'name': 'Giáo Dục Quốc Phòng',
        'icon': 'assets/images/Military_icon.png'
      },
      {
        'name': 'Giáo Dục Đặc Biệt',
        'icon': 'assets/images/Special_Education_icon.png'
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (240 / subjectGridSize).toInt(),
          childAspectRatio: 0.9,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemCount: defaultSubjects.length,
        itemBuilder: (context, index) {
          return _buildSubjectItem(
            context: context,
            subjectName: subjects[index]['name']!,
            assetLocation: subjects[index]['icon']!,
            subjectSize: subjectGridSize,
          );
        },
      ),
    );
  }

  Widget _buildSubjectItem({
    required BuildContext context,
    required String subjectName,
    required String assetLocation,
    required double subjectSize,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(title: subjectName),
              ),
            );
          },
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: subjectSize,
        height: subjectSize,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            Container(
              width: subjectSize - 10,
              height: subjectSize - 10,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: subjectSize - 10,
                      height: subjectSize - 10,
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
              width: subjectSize + 10,
              child: Text(
                subjectName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: subjectSize / 5,
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
    );
  }

  Widget _tempCreateLesson(String title, String value) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateLessonPage(),
          ),
        );
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 22.22,
              child: Text(
                title,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.27,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
