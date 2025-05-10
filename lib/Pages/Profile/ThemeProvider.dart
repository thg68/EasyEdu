import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  double _fontSize = 16.0;
  bool _highContrast = false;
  bool _boldText = false;
  double _lineHeight = 1.2;
  Color _textColor = Colors.black;
  Color _backgroundColor = Colors.white;

  // Getters
  double get fontSize => _fontSize;
  bool get highContrast => _highContrast;
  bool get boldText => _boldText;
  double get lineHeight => _lineHeight;
  Color get textColor => _textColor;
  Color get backgroundColor => _backgroundColor;

  // Initialize settings
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble('fontSize') ?? 22.0;
    _highContrast = prefs.getBool('highContrast') ?? false;
    _boldText = prefs.getBool('boldText') ?? false;
    _lineHeight = prefs.getDouble('lineHeight') ?? 1.2;

    // Load colors
    int textColorValue = prefs.getInt('textColor') ?? Colors.black.value;
    int bgColorValue = prefs.getInt('backgroundColor') ?? Colors.white.value;
    _textColor = Color(textColorValue);
    _backgroundColor = Color(bgColorValue);

    // Apply high contrast if enabled
    if (_highContrast) {
      _textColor = Colors.white;
      _backgroundColor = Colors.black;
    }

    notifyListeners();
  }

  // Update settings
  Future<void> updateSettings({
    double? fontSize,
    bool? highContrast,
    bool? boldText,
    double? lineHeight,
    Color? textColor,
    Color? backgroundColor,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    if (fontSize != null) {
      _fontSize = fontSize;
      await prefs.setDouble('fontSize', fontSize);
    }

    if (highContrast != null) {
      _highContrast = highContrast;
      await prefs.setBool('highContrast', highContrast);

      // Update colors for high contrast
      if (highContrast) {
        _textColor = Colors.white;
        _backgroundColor = Colors.black;
      } else {
        _textColor = Colors.black;
        _backgroundColor = Colors.white;
      }

      await prefs.setInt('textColor', _textColor.value);
      await prefs.setInt('backgroundColor', _backgroundColor.value);
    }

    if (boldText != null) {
      _boldText = boldText;
      await prefs.setBool('boldText', boldText);
    }

    if (lineHeight != null) {
      _lineHeight = lineHeight;
      await prefs.setDouble('lineHeight', lineHeight);
    }

    if (textColor != null && !_highContrast) {
      _textColor = textColor;
      await prefs.setInt('textColor', textColor.value);
    }

    if (backgroundColor != null && !_highContrast) {
      _backgroundColor = backgroundColor;
      await prefs.setInt('backgroundColor', backgroundColor.value);
    }

    notifyListeners();
  }

  // Get text style with current settings
  TextStyle get textStyle => TextStyle(
        fontSize: _fontSize,
        fontWeight: _boldText ? FontWeight.bold : FontWeight.normal,
        height: _lineHeight,
        color: _textColor,
      );

  // Reset all settings to default
  Future<void> resetSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _fontSize = 22.0;
    _highContrast = false;
    _boldText = false;
    _lineHeight = 1.2;
    _textColor = Colors.black;
    _backgroundColor = Colors.white;

    notifyListeners();
  }
}
