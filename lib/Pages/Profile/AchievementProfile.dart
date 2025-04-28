import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ThemeProvider.dart';

class AchievementProfile extends StatelessWidget {
  const AchievementProfile({Key? key}) : super(key: key);

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
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildAchievementCard(
                context,
                title: 'Bài học đã hoàn thành',
                value: '5',
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
                'Huy hiệu đạt được',
                [
                  _buildBadge('Người học chăm chỉ', 'assets/images/badge1.png',
                      themeProvider),
                  _buildBadge('Điểm cao nhất tuần', 'assets/images/badge2.png',
                      themeProvider),
                  _buildBadge('Chuỗi 7 ngày', 'assets/images/badge3.png',
                      themeProvider),
                ],
                themeProvider,
              ),
              _buildAchievementSection(
                context,
                'Thành tích gần đây',
                [
                  _buildRecentAchievement(
                    'Tung Tung Sahur',
                    '2 ngày trước',
                    themeProvider,
                  ),
                  _buildRecentAchievement(
                    'tralalero tralala',
                    '1 tuần trước',
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
            ),
          ),
        ),
        ...items,
      ],
    );
  }

  Widget _buildBadge(
      String name, String imagePath, ThemeProvider themeProvider) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Image.asset(
          imagePath,
          width: 40 * (themeProvider.fontSize / 16),
          height: 40 * (themeProvider.fontSize / 16),
        ),
        title: Text(
          name,
          style: TextStyle(fontSize: themeProvider.fontSize),
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
      child: ListTile(
        title: Text(
          achievement,
          style: TextStyle(fontSize: themeProvider.fontSize),
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
