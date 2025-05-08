import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ThemeProvider.dart'; // Import ThemeProvider

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isTextToSpeechEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isTextToSpeechEnabled = prefs.getBool('textToSpeech') ?? false;
    });
  }

  Future<void> _saveTextToSpeech(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('textToSpeech', value);
  }

  // Hàm để hiển thị kích thước chữ theo một format đẹp hơn
  String _formatFontSize(double size) {
    return '${size.round()} pt';
  }

  // Hàm tạo chuỗi ví dụ với kích thước tương ứng
  Widget _buildFontSizePreview(double fontSize) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Text(
        'AaBbCc - Văn bản ví dụ',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Cài đặt hỗ trợ',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 1,
            centerTitle: true,
          ),
          body: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tùy chỉnh hiển thị',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Kích thước chữ',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      _buildFontSizePreview(themeProvider.fontSize),
                      Row(
                        children: [
                          const Text('A', style: TextStyle(fontSize: 14)),
                          Expanded(
                            child: Slider(
                              value: themeProvider.fontSize,
                              min: 12.0,
                              max: 32.0,
                              divisions: 10,
                              activeColor: Colors.blue,
                              inactiveColor: Colors.blue.withOpacity(0.2),
                              label: _formatFontSize(themeProvider.fontSize),
                              onChanged: (double value) {
                                themeProvider.updateSettings(fontSize: value);
                              },
                            ),
                          ),
                          const Text('A', style: TextStyle(fontSize: 24)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatFontSize(themeProvider.fontSize),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                color: themeProvider.fontSize > 12.0
                                    ? Colors.blue
                                    : Colors.grey,
                                onPressed: themeProvider.fontSize > 12.0
                                    ? () {
                                        double newSize =
                                            themeProvider.fontSize - 2.0;
                                        if (newSize < 12.0) newSize = 12.0;
                                        themeProvider.updateSettings(
                                            fontSize: newSize);
                                      }
                                    : null,
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                color: themeProvider.fontSize < 32.0
                                    ? Colors.blue
                                    : Colors.grey,
                                onPressed: themeProvider.fontSize < 32.0
                                    ? () {
                                        double newSize =
                                            themeProvider.fontSize + 2.0;
                                        if (newSize > 32.0) newSize = 32.0;
                                        themeProvider.updateSettings(
                                            fontSize: newSize);
                                      }
                                    : null,
                              ),
                              IconButton(
                                icon: const Icon(Icons.refresh),
                                color: themeProvider.fontSize != 22.0
                                    ? Colors.blue
                                    : Colors.grey,
                                onPressed: themeProvider.fontSize != 22.0
                                    ? () {
                                        themeProvider.updateSettings(fontSize: 22.0);
                                      }
                                    : null,
                                tooltip: 'Đặt lại kích thước mặc định',
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      SwitchListTile(
                        title: const Text('Độ tương phản cao'),
                        subtitle: const Text('Tăng độ tương phản màu sắc'),
                        value: themeProvider.highContrast,
                        activeColor: Colors.blue,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (bool value) {
                          themeProvider.updateSettings(highContrast: value);
                        },
                      ),
                      const Divider(height: 16),
                      SwitchListTile(
                        title: const Text('Chữ đậm'),
                        subtitle: const Text('Hiển thị chữ đậm hơn'),
                        value: themeProvider.boldText,
                        activeColor: Colors.blue,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (bool value) {
                          themeProvider.updateSettings(boldText: value);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tùy chỉnh trợ năng',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        title: const Text('Đọc văn bản'),
                        subtitle: const Text('Bật tính năng đọc văn bản'),
                        value: _isTextToSpeechEnabled,
                        activeColor: Colors.blue,
                        contentPadding: EdgeInsets.zero,
                        onChanged: (bool value) {
                          setState(() {
                            _isTextToSpeechEnabled = value;
                            _saveTextToSpeech(value);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.restore),
                label: const Text('Khôi phục cài đặt mặc định'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Khôi phục cài đặt'),
                      content: const Text(
                          'Bạn có chắc muốn khôi phục tất cả cài đặt về mặc định không?'),
                      actions: [
                        TextButton(
                          child: const Text('Hủy'),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                        TextButton(
                          child: const Text(
                            'Xác nhận',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            themeProvider.resetSettings();
                            setState(() {
                              _isTextToSpeechEnabled = false;
                              _saveTextToSpeech(false);
                            });
                            Navigator.of(ctx).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Đã khôi phục cài đặt mặc định'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
