import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Profile/ThemeProvider.dart';

class LessonPage extends StatefulWidget {
  final String title;

  const LessonPage({required this.title, super.key});

  @override
  LessonPageState createState() => LessonPageState();
}

class LessonPageState extends State<LessonPage> {
  double _getFontSize(BuildContext context) {
    return Provider.of<ThemeProvider>(context, listen: true).fontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildText('1. Định nghĩa hàm số', 'header1'),
            const SizedBox(height: 8),
            _buildText(
                'Hàm số là một quy tắc ánh xạ, trong đó mỗi giá trị của biến số đầu vào (gọi là biến độc lập) tương ứng với một giá trị duy nhất của biến số đầu ra (gọi là biến phụ thuộc).'),
            const SizedBox(height: 16),
            _buildText('2. Tập xác định', 'header1'),
            const SizedBox(height: 8),
            _buildText(
                'Tập xác định của hàm số f(x) là tập hợp tất cả các giá trị của x mà hàm số được xác định.'),
            const SizedBox(height: 16),
            _buildText('3. Các loại hàm số cơ bản', 'header1'),
            const SizedBox(height: 8),
            _buildText(
                '- Hàm số bậc nhất: y = ax + b (a ≠ 0). Đồ thị là đường thẳng.'),
            _buildText(
                '- Hàm số bậc hai: y = ax² + bx + c (a ≠ 0). Đồ thị là parabol.'),
            _buildText(
                '- Hàm số phân thức: y = P(x) / Q(x), trong đó Q(x) ≠ 0.'),
            _buildText(
                '- Hàm số lượng giác: Ví dụ: y = sin(x), y = cos(x), y = tan(x).'),
            const SizedBox(height: 16),
            _buildText('4. Tính chất của hàm số', 'header1'),
            const SizedBox(height: 8),
            _buildText('- Hàm số đồng biến: Khi x₁ < x₂ thì f(x₁) < f(x₂).'),
            _buildText('- Hàm số nghịch biến: Khi x₁ < x₂ thì f(x₁) > f(x₂).'),
            _buildText(
                '- Hàm số chẵn: f(-x) = f(x) với mọi x thuộc tập xác định.'),
            _buildText(
                '- Hàm số lẻ: f(-x) = -f(x) với mọi x thuộc tập xác định.'),
            const SizedBox(height: 16),
            _buildText('5. Đồ thị hàm số', 'header1'),
            const SizedBox(height: 8),
            _buildText(
                'Đồ thị của hàm số là tập hợp tất cả các điểm (x, y) trên mặt phẳng tọa độ thỏa mãn y = f(x).'),
            const SizedBox(height: 16),
            _buildText('6. Bài tập', 'header1'),
            const SizedBox(height: 8),
            _buildText('Bài 1. Xác định tập xác định của các hàm số sau:'),
            _buildText('   - f(x) = 1 / (x - 2).'),
            _buildText('   - g(x) = √(x + 3).'),
            ElevatedButton.icon(
              icon: const Icon(Icons.search),
              label: const Text('Lời giải bài 1'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade100,
                foregroundColor: Colors.purple,
              ),
              onPressed: () {
                _showAnswer(context, 'Bài 1');
              },
            ),
            _buildText('Bài 2. Vẽ đồ thị của các hàm số:'),
            _buildText('   - y = 2x + 1.'),
            _buildText('   - y = x² - 4x + 3.'),
            ElevatedButton.icon(
              icon: const Icon(Icons.search),
              label: const Text('Lời giải bài 2'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade100,
                foregroundColor: Colors.purple,
              ),
              onPressed: () {
                _showAnswer(context, 'Bài 2');
              },
            ),
            _buildText('Bài 3. Kiểm tra tính chẵn, lẻ của các hàm số:'),
            _buildText('   - f(x) = x³ - x.'),
            _buildText('   - g(x) = x² + 1.'),
            ElevatedButton.icon(
              icon: const Icon(Icons.search),
              label: const Text('Lời giải bài 3'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade100,
                foregroundColor: Colors.purple,
              ),
              onPressed: () {
                _showAnswer(context, 'Bài 3');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(String content, [String? header]) {
    double fontSize = _getFontSize(context);
    if (header == 'header1') {
      fontSize += 2;
    }

    return Text(
      content,
      style: TextStyle(fontSize: fontSize),
    );
  }

  void _showAnswer(
    BuildContext context,
    String question,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    question,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              const Text(
                'Đáp án:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (question == 'Bài 1') ...[
                _buildText('- Tập xác định của hàm số f(x) = 1 / (x - 2):'),
                _buildText('  D_f = {x ∈ ℝ | x ≠ 2}.'),
                const SizedBox(height: 8),
                _buildText('- Tập xác định của hàm số g(x) = √(x + 3):'),
                _buildText('  D_g = {x ∈ ℝ | x ≥ -3}.'),
              ] else if (question == 'Bài 2') ...[
                _buildText(
                    '- Đồ thị của hàm số y = 2x + 1 là một đường thẳng.'),
                const SizedBox(height: 8),
                _buildText(
                    '- Đồ thị của hàm số y = x² - 4x + 3 là một parabol.'),
              ] else if (question == 'Bài 3') ...[
                _buildText('- Hàm số f(x) = x³ - x là hàm lẻ.'),
                const SizedBox(height: 8),
                _buildText('- Hàm số g(x) = x² + 1 là hàm chẵn.'),
              ] else ...[
                _buildText('Không có đáp án cho câu hỏi này.'),
              ],
            ],
          ),
        );
      },
    );
  }
}
