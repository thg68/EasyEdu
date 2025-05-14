import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ThemeProvider.dart';

class SubjectProgress {
  final String name;
  final double progress;
  final int completedLessons;
  final int totalLessons;
  final List<Lesson> lessons;
  final Color color;
  final String iconPath;

  SubjectProgress({
    required this.name,
    required this.progress,
    required this.completedLessons,
    required this.totalLessons,
    required this.lessons,
    required this.color,
    required this.iconPath,
  });
}

class Lesson {
  final String name;
  final bool isCompleted;
  final String completedDate;

  Lesson({
    required this.name,
    required this.isCompleted,
    required this.completedDate,
  });
}

class TrackLearning extends StatelessWidget {
  final List<SubjectProgress> subjects = [
    SubjectProgress(
      name: 'Toán học',
      progress: 0.85,
      completedLessons: 17,
      totalLessons: 20,
      color: Colors.blue,
      iconPath: 'assets/images/Algebra_icon.png',
      lessons: [
        Lesson(
          name: 'Đại số tuyến tính',
          isCompleted: true,
          completedDate: '02/05/2025',
        ),
        Lesson(
          name: 'Giải tích cơ bản',
          isCompleted: true,
          completedDate: '04/05/2025',
        ),
        Lesson(
          name: 'Xác suất thống kê',
          isCompleted: false,
          completedDate: '',
        ),
      ],
    ),
    SubjectProgress(
      name: 'Vật lý',
      progress: 0.70,
      completedLessons: 14,
      totalLessons: 20,
      color: Colors.purple,
      iconPath: 'assets/images/Physics_icon.png',
      lessons: [
        Lesson(
          name: 'Cơ học Newton',
          isCompleted: true,
          completedDate: '01/05/2025',
        ),
        Lesson(
          name: 'Điện từ học',
          isCompleted: true,
          completedDate: '03/05/2025',
        ),
        Lesson(
          name: 'Quang học hiện đại',
          isCompleted: false,
          completedDate: '',
        ),
      ],
    ),
    SubjectProgress(
      name: 'Hóa học',
      progress: 0.60,
      completedLessons: 12,
      totalLessons: 20,
      color: Colors.green,
      iconPath: 'assets/images/Chemistry_icon.png',
      lessons: [
        Lesson(
          name: 'Cấu tạo nguyên tử',
          isCompleted: true,
          completedDate: '28/04/2025',
        ),
        Lesson(
          name: 'Phản ứng hóa học',
          isCompleted: true,
          completedDate: '30/04/2025',
        ),
        Lesson(
          name: 'Hóa học hữu cơ',
          isCompleted: false,
          completedDate: '',
        ),
      ],
    ),
    SubjectProgress(
      name: 'Sinh học',
      progress: 0.50,
      completedLessons: 10,
      totalLessons: 20,
      color: Colors.teal,
      iconPath: 'assets/images/Biology_icon.png',
      lessons: [
        Lesson(
          name: 'Tế bào học',
          isCompleted: true,
          completedDate: '25/04/2025',
        ),
        Lesson(
          name: 'Di truyền học',
          isCompleted: true,
          completedDate: '29/04/2025',
        ),
        Lesson(
          name: 'Sinh thái học',
          isCompleted: false,
          completedDate: '',
        ),
      ],
    ),
    SubjectProgress(
      name: 'Lịch sử',
      progress: 0.65,
      completedLessons: 13,
      totalLessons: 20,
      color: Colors.brown,
      iconPath: 'assets/images/History_icon.png',
      lessons: [
        Lesson(
          name: 'Lịch sử Việt Nam',
          isCompleted: true,
          completedDate: '26/04/2025',
        ),
        Lesson(
          name: 'Lịch sử thế giới',
          isCompleted: true,
          completedDate: '02/05/2025',
        ),
        Lesson(
          name: 'Văn minh thế giới',
          isCompleted: false,
          completedDate: '',
        ),
      ],
    ),
  ];

  TrackLearning({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Theo dõi học tập',
              style: TextStyle(
                fontSize: themeProvider.fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Color(0xFF9575CD),
            foregroundColor: Colors.white,
            centerTitle: true,
            elevation: 1,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildDailyProgress(themeProvider),
              _buildLearningStats(themeProvider),
              _buildSubjectsProgress(context, themeProvider),
              _buildTodayActivities(themeProvider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDailyProgress(ThemeProvider themeProvider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mục tiêu hôm nay',
              style: TextStyle(
                fontSize: themeProvider.fontSize * 1.2,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: Color(0xFF9575CD).withOpacity(0.2),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Color(0xFF9575CD)),
              minHeight: 10,
            ),
            const SizedBox(height: 8),
            Text(
              'Đã học 2.5/3 giờ',
              style: TextStyle(
                fontSize: themeProvider.fontSize,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLearningStats(ThemeProvider themeProvider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          _buildStatCard(
            'Thời gian\nhọc hôm nay',
            '2.5h',
            Icons.timer,
            Color(0xFF9575CD),
            themeProvider,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            'Bài học\nđã xem',
            '5',
            Icons.visibility,
            Colors.green,
            themeProvider,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            'Bài tập\nđã làm',
            '3',
            Icons.assignment_turned_in,
            Colors.orange,
            themeProvider,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    ThemeProvider themeProvider,
  ) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon,
                  color: color, size: 24 * (themeProvider.fontSize / 16)),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: themeProvider.fontSize * 0.8,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: themeProvider.fontSize * 1.2,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectsProgress(
      BuildContext context, ThemeProvider themeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'Tiến độ môn học hôm nay',
            style: TextStyle(
              fontSize: themeProvider.fontSize * 1.1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...subjects.map((subject) => _buildSubjectCard(subject, themeProvider)),
      ],
    );
  }

  Widget _buildSubjectCard(
      SubjectProgress subject, ThemeProvider themeProvider) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36 * (themeProvider.fontSize / 16),
                      height: 36 * (themeProvider.fontSize / 16),
                      decoration: BoxDecoration(
                        color: subject.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          subject.iconPath,
                          width: 36 * (themeProvider.fontSize / 16),
                          height: 36 * (themeProvider.fontSize / 16),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.book,
                              color: subject.color,
                              size: 20 * (themeProvider.fontSize / 16),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      subject.name,
                      style: TextStyle(
                        fontSize: themeProvider.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${(subject.progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: themeProvider.fontSize,
                    color: subject.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: subject.progress,
              backgroundColor: subject.color.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(subject.color),
              minHeight: 8,
            ),
            const SizedBox(height: 8),
            Text(
              'Hôm nay: ${subject.completedLessons}/${subject.totalLessons} bài học',
              style: TextStyle(
                fontSize: themeProvider.fontSize * 0.9,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            ExpansionTile(
              title: Text(
                'Bài học hôm nay',
                style: TextStyle(fontSize: themeProvider.fontSize * 0.9),
              ),
              children: subject.lessons
                  .map((lesson) => _buildLessonItem(
                        lesson,
                        subject.color,
                        themeProvider,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonItem(
    Lesson lesson,
    Color subjectColor,
    ThemeProvider themeProvider,
  ) {
    return ListTile(
      leading: Icon(
        lesson.isCompleted ? Icons.check_circle : Icons.pending,
        color: lesson.isCompleted ? subjectColor : Colors.grey,
      ),
      title: Text(
        lesson.name,
        style: TextStyle(fontSize: themeProvider.fontSize * 0.9),
      ),
      subtitle: Text(
        lesson.isCompleted
            ? 'Hoàn thành lúc: ${lesson.completedDate}'
            : 'Đang học',
        style: TextStyle(fontSize: themeProvider.fontSize * 0.8),
      ),
    );
  }

  Widget _buildTodayActivities(ThemeProvider themeProvider) {
    return Card(
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hoạt động hôm nay',
              style: TextStyle(
                fontSize: themeProvider.fontSize * 1.1,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildActivityItem(
              'Bắt đầu bài Giải tích',
              '5 phút trước',
              Icons.play_circle_fill,
              Color(0xFF9575CD),
              themeProvider,
            ),
            _buildActivityItem(
              'Hoàn thành bài Giải tích',
              '1 giờ trước',
              Icons.assignment_turned_in,
              Colors.green,
              themeProvider,
            ),
            _buildActivityItem(
              'Xem video Web',
              '2 giờ trước',
              Icons.visibility,
              Colors.orange,
              themeProvider,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String time,
    IconData icon,
    Color color,
    ThemeProvider themeProvider,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24 * (themeProvider.fontSize / 16)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: themeProvider.fontSize),
                ),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: themeProvider.fontSize * 0.8,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
