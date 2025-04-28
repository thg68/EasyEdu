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

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Cài đặt hỗ trợ'),
          ),
          body: ListView(
            children: [
              SwitchListTile(
                title: const Text('Đọc văn bản'),
                subtitle: const Text('Bật tính năng đọc văn bản'),
                value: _isTextToSpeechEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isTextToSpeechEnabled = value;
                    _saveTextToSpeech(value);
                  });
                },
              ),
              ListTile(
                title: const Text('Kích thước chữ'),
                subtitle: Slider(
                  value: themeProvider.fontSize,
                  min: 12.0,
                  max: 32.0,
                  divisions: 10,
                  label: themeProvider.fontSize.round().toString(),
                  onChanged: (double value) {
                    themeProvider.updateSettings(fontSize: value);
                  },
                ),
              ),
              SwitchListTile(
                title: const Text('Độ tương phản cao'),
                subtitle: const Text('Tăng độ tương phản màu sắc'),
                value: themeProvider.highContrast,
                onChanged: (bool value) {
                  themeProvider.updateSettings(highContrast: value);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
