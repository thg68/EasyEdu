import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Profile/ThemeProvider.dart';

class ExamPage extends StatefulWidget {
  final String title;

  const ExamPage({required this.title, super.key});

  @override
  ExamPageState createState() => ExamPageState();
}

class ExamPageState extends State<ExamPage> {
  double _getFontSize(BuildContext context) {
    return Provider.of<ThemeProvider>(context, listen: true).fontSize;
  }

  int _score = 0;
  int _currentQuestion = 0;
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Tập xác định của hàm số y = 1/(x-2) là:',
      'answers': ['R', 'R \\ {2}', 'R \\ {0}', 'R*'],
      'correct': 1,
    },
    {
      'question': 'Hàm số nào sau đây là hàm số chẵn?',
      'answers': ['y = x^3', 'y = x^2', 'y = x^3 + x', 'y = x^3 - x'],
      'correct': 1,
    },
    {
      'question': 'Đồ thị hàm số y = x^2 là:',
      'answers': ['Đường thẳng', 'Parabol', 'Đường tròn', 'Elip'],
      'correct': 1,
    },
    {
      'question':
          'Giá trị lớn nhất của hàm số y = -x^2 + 4x + 5 trên đoạn [0;5] là:',
      'answers': ['5', '9', '16', '20'],
      'correct': 2,
    },
  ];

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
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Color(0xFFF3E8FF),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                'Điểm: $_score/${_questions.length}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildText(
                    'Câu ${_currentQuestion + 1}: ${_questions[_currentQuestion]['question']}',
                    'header1'),
                const SizedBox(height: 24),
                ...List.generate(
                  (_questions[_currentQuestion]['answers'] as List).length,
                  (i) => Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.purple,
                        side: const BorderSide(color: Colors.purple),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _answerQuestion(i),
                      child: _buildText(
                        _questions[_currentQuestion]['answers'][i],
                      ),
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

  Widget _buildText(String content, [String? header, Color? color]) {
    double fontSize = _getFontSize(context);
    if (header == 'header1') {
      fontSize += 2;
    } else if (header == 'header2') {
      fontSize += 4;
    }

    return Text(
      content,
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? Colors.black,
      ),
    );
  }

  void _answerQuestion(int selected) {
    if (_questions[_currentQuestion]['correct'] == selected) {
      setState(() {
        _score++;
      });
    }
    if (_currentQuestion < _questions.length - 1) {
      setState(() {
        _currentQuestion++;
      });
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Hoàn thành bài kiểm tra'),
          content: _buildText('Bạn đã đạt $_score/${_questions.length} điểm!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
