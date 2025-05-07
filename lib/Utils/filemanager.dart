import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class SubjectFileManager {
  static const String _subjectsFilePath = 'assets/data/subjects.json';
  static const String _eventsAssetPath = 'assets/data/events.json';
  static const String _eventsFileName = 'events.json';

  static Future<List<Map<String, String>>> readSubjects() async {
    try {
      final String jsonString = await rootBundle.loadString(_subjectsFilePath);
      final List<dynamic> jsonData = json.decode(jsonString);
      return jsonData.map((item) =>
      Map<String, String>.from(item)
      ).toList();
    } catch (e) {
      print('Error reading subjects: $e');
      return _defaultSubjects;
    }
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _eventsFile async {
    final path = await _localPath;
    return File('$path/$_eventsFileName');
  }

  static Future<File> _ensureEventsFile() async {
    try {
      File file = await _eventsFile;
      bool exists = await file.exists();

      if (!exists) {
        try {
          String defaultContent = await rootBundle.loadString(_eventsAssetPath);
          return await file.writeAsString(defaultContent);
        } catch (e) {
          return await file.writeAsString(json.encode({}));
        }
      }

      return file;
    } catch (e) {
      print('Error ensuring events file: $e');
      File file = await _eventsFile;
      return await file.writeAsString(json.encode({}));
    }
  }

  static Future<Map<String, List<Map<String, dynamic>>>> readEvents() async {
    try {
      File file = await _ensureEventsFile();
      String jsonString = await file.readAsString();

      if (jsonString.isEmpty) {
        jsonString = await rootBundle.loadString(_eventsAssetPath);
        await file.writeAsString(jsonString);
      }

      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final Map<String, List<Map<String, dynamic>>> result = {};

      jsonData.forEach((key, value) {
        result[key] = (value as List).map((item) =>
        Map<String, dynamic>.from(item)
        ).toList();
      });

      return result;
    } catch (e) {
      print('Error reading events: $e');
      return {};
    }
  }

  static Future<void> writeEvents(Map<String, List<Map<String, dynamic>>> events) async {
    try {
      final File file = await _ensureEventsFile();
      final Map<String, List<dynamic>> jsonMap = {};
      events.forEach((key, eventList) {
        jsonMap[key] = eventList.map((event) => event).toList();
      });

      final String jsonString = json.encode(jsonMap);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error writing events: $e');
    }
  }

  // Default subjects (used when file is blank)
  static final List<Map<String, String>> _defaultSubjects = [
    {
      'name': 'Đại Số',
      'tchr': 'Trần Thanh Hoa',
      'romm': 'P301',
      'bdng': 'C2',
      'icon': 'assets/images/Algebra_icon.png'
    },
    //some more here
    {
      'name': 'Giáo Dục Đặc Biệt',
      'tchr': 'Phan Thị Lan',
      'romm': 'P103',
      'bdng': 'B3',
      'icon': 'assets/images/Special_Education_icon.png'
    },
  ];
}