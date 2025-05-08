import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ThemeProvider.dart';

class AchievementProfile extends StatelessWidget {
  const AchievementProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Thành tích của tôi',
              style: TextStyle(
                fontSize: themeProvider.fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            centerTitle: true,
            elevation: 1,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildAchievementCard(
                context,
                title: 'Bài học đã hoàn thành',
                value: '12',
                icon: Icons.book,
                color: Colors.blue,
                themeProvider: themeProvider,
              ),
              _buildAchievementCard(
                context,
                title: 'Điểm trung bình',
                value: '8.5',
                icon: Icons.star,
                color: Colors.orange,
                themeProvider: themeProvider,
              ),
              _buildAchievementCard(
                context,
                title: 'Chuỗi ngày học',
                value: '7',
                icon: Icons.local_fire_department,
                color: Colors.red,
                themeProvider: themeProvider,
              ),
              _buildAchievementSection(
                context,
                'Thành tích theo môn học',
                [
                  _buildSubjectAchievement(
                    'Toán học',
                    '9.0',
                    'assets/images/Algebra_icon.png',
                    themeProvider,
                    '4 bài học đã hoàn thành',
                  ),
                  _buildSubjectAchievement(
                    'Vật lý',
                    '8.5',
                    'assets/images/Physics_icon.png',
                    themeProvider,
                    '3 bài học đã hoàn thành',
                  ),
                  _buildSubjectAchievement(
                    'Hóa học',
                    '7.5',
                    'assets/images/Chemistry_icon.png',
                    themeProvider,
                    '2 bài học đã hoàn thành',
                  ),
                  _buildSubjectAchievement(
                    'Sinh học',
                    '8.0',
                    'assets/images/Biology_icon.png',
                    themeProvider,
                    '3 bài học đã hoàn thành',
                  ),
                ],
                themeProvider,
              ),
              _buildAchievementSection(
                context,
                'Huy hiệu đạt được',
                [
                  _buildBadge(
                      'Người học chăm chỉ',
                      'assets/images/home_icon.png',
                      themeProvider,
                      'Hoàn thành 5 bài học liên tiếp'),
                  _buildBadge(
                      'Điểm cao nhất tuần',
                      'assets/images/notification_icon.png',
                      themeProvider,
                      'Đạt điểm cao nhất trong tuần qua'),
                  _buildBadge('Chuỗi 7 ngày', 'assets/images/profile_icon.png',
                      themeProvider, 'Học liên tục 7 ngày không gián đoạn'),
                ],
                themeProvider,
              ),
              _buildAchievementSection(
                context,
                'Thành tích gần đây',
                [
                  _buildRecentAchievement(
                    'Hoàn thành bài học Đại số',
                    '2 ngày trước',
                    themeProvider,
                  ),
                  _buildRecentAchievement(
                    'Đạt điểm 9.0 trong bài kiểm tra Vật lý',
                    '1 tuần trước',
                    themeProvider,
                  ),
                  _buildRecentAchievement(
                    'Hoàn thành chuỗi học 7 ngày',
                    '2 tuần trước',
                    themeProvider,
                  ),
                ],
                themeProvider,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAchievementCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required ThemeProvider themeProvider,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon,
                  color: color, size: 24 * (themeProvider.fontSize / 16)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: themeProvider.fontSize * 0.9,
                      color: Colors.grey[600],
                      fontWeight: themeProvider.boldText
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: themeProvider.fontSize * 1.2,
                      fontWeight: FontWeight.bold,
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

  Widget _buildAchievementSection(
    BuildContext context,
    String title,
    List<Widget> items,
    ThemeProvider themeProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            title,
            style: TextStyle(
              fontSize: themeProvider.fontSize * 1.1,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
        ),
        ...items,
      ],
    );
  }

  Widget _buildSubjectAchievement(
    String subject,
    String score,
    String iconPath,
    ThemeProvider themeProvider,
    String description,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Sử dụng ClipRRect để tránh lỗi hiển thị ảnh
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                iconPath,
                width: 50 * (themeProvider.fontSize / 16),
                height: 50 * (themeProvider.fontSize / 16),
                errorBuilder: (context, error, stackTrace) {
                  // Widget hiển thị khi lỗi
                  return Container(
                    width: 50 * (themeProvider.fontSize / 16),
                    height: 50 * (themeProvider.fontSize / 16),
                    color: Colors.grey.shade200,
                    child: Icon(Icons.book, color: Colors.grey.shade400),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: TextStyle(
                      fontSize: themeProvider.fontSize * 0.95,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: themeProvider.fontSize * 0.8,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                score,
                style: TextStyle(
                  fontSize: themeProvider.fontSize * 0.9,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(
    String name,
    String imagePath,
    ThemeProvider themeProvider,
    String description,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
            width: 40 * (themeProvider.fontSize / 16),
            height: 40 * (themeProvider.fontSize / 16),
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 40 * (themeProvider.fontSize / 16),
                height: 40 * (themeProvider.fontSize / 16),
                color: Colors.grey.shade200,
                child: Icon(Icons.emoji_events, color: Colors.amber),
              );
            },
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontSize: themeProvider.fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontSize: themeProvider.fontSize * 0.8,
          ),
        ),
      ),
    );
  }

  Widget _buildRecentAchievement(
    String achievement,
    String timeAgo,
    ThemeProvider themeProvider,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          achievement,
          style: TextStyle(
            fontSize: themeProvider.fontSize,
            fontWeight:
                themeProvider.boldText ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
        subtitle: Text(
          timeAgo,
          style: TextStyle(fontSize: themeProvider.fontSize * 0.8),
        ),
        trailing: const Icon(Icons.emoji_events, color: Colors.amber),
      ),
    );
  }
}
