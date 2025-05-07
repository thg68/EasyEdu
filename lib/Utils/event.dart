import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';
import '../../Utils/filemanager.dart';

class Event {
  final String title;
  final String? startTime;
  final String? endTime;
  final String? room;
  final String? building;
  final String? subject;
  final String? teacher;

  const Event({
    required this.title,
    this.startTime,
    this.endTime,
    this.room,
    this.building,
    this.subject,
    this.teacher,
  });

  String get timeRange {
    if (startTime != null && endTime != null) {
      return '$startTime - $endTime';
    }
    return '';
  }

  String get location {
    if (room != null && building != null) {
      return '$room - $building';
    } else if (room != null) {
      return room!;
    } else if (building != null) {
      return building!;
    }
    return '';
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'room': room,
      'building': building,
      'subject': subject,
      'teacher': teacher,
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      room: json['room'],
      building: json['building'],
      subject: json['subject'],
      teacher: json['teacher'],
    );
  }

  @override
  String toString() => title;
}

void addEventToCalendar(Event event, DateTime date) {
  final eventDate = DateTime.utc(date.year, date.month, date.day);
  if (kEvents.containsKey(eventDate)) {
    kEvents[eventDate]!.add(event);
  } else {
    kEvents[eventDate] = [event];
  }
  saveEventsToFile();
}

Future<void> saveEventsToFile() async {
  final Map<String, List<Map<String, dynamic>>> eventsMap = {};

  kEvents.forEach((date, events) {
    final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    eventsMap[dateStr] = events.map((event) => event.toJson()).toList();
  });

  await SubjectFileManager.writeEvents(eventsMap);
}

Event createLessonEvent({
  required String title,
  required String subject,
  required String startTime,
  required String endTime,
  String? room,
  String? building,
  String? teacher,
}) {
  return Event(
    title: title,
    subject: subject,
    startTime: startTime,
    endTime: endTime,
    room: room,
    building: building,
    teacher: teacher,
  );
}

Future<void> deleteEventFromCalendar(Event event, DateTime date) async {
  final eventDate = DateTime.utc(date.year, date.month, date.day);
  if (kEvents.containsKey(eventDate)) {
    kEvents[eventDate]!.removeWhere((e) =>
    e.title == event.title &&
        e.startTime == event.startTime &&
        e.endTime == event.endTime
    );

    if (kEvents[eventDate]!.isEmpty) {
      kEvents.remove(eventDate);
    }

    await saveEventsToFile();
  }
}

int getHashCode(DateTime key) =>
    key.day * 1000000 + key.month * 10000 + key.year;

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
);

Future<void> loadEventsFromFile() async {
  kEvents.clear();

  final eventsMap = await SubjectFileManager.readEvents();

  eventsMap.forEach((dateKey, eventsData) {
    final parts = dateKey.split('-');
    if (parts.length == 3) {
      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);
      final date = DateTime.utc(year, month, day);

      kEvents[date] = eventsData
          .map((eventData) => Event.fromJson(Map<String, dynamic>.from(eventData)))
          .toList();
    }
  });
}

//Custom populate the events with subjects,
// rotating schedule weekly, only morning session on Saturday
// monthly spread on days 5, 10, 15, 20, 25, last day,

Future<void> populateStudentSchedule() async {
  final List<Map<String, String>> subjects = await SubjectFileManager.readSubjects();

  final weeklySubjects = subjects.sublist(0, subjects.length - 6);
  final monthlySubjects = subjects.sublist(subjects.length - 6);

  final morningSlots = [
    {'start': '07:00', 'end': '08:20'},
    {'start': '08:35', 'end': '09:55'},
    {'start': '10:10', 'end': '11:30'},
  ];
  final afternoonSlots = [
    {'start': '14:00', 'end': '15:20'},
  ];

  final allDays = daysInRange(kFirstDay, kLastDay);
  for (var date in allDays) {
    if (date.weekday == DateTime.sunday) continue;
    final idxBase = date.difference(kFirstDay).inDays % weeklySubjects.length;

    if (date.weekday == DateTime.saturday) {
      final subj = weeklySubjects[idxBase];
      final slot = morningSlots[0];
      addEventToCalendar(
        createLessonEvent(
          title: '${subj['name']} Class',
          subject: subj['name']!,
          startTime: slot['start']!,
          endTime: slot['end']!,
          room: subj['romm']!,
          building: subj['bdng']!,
          teacher: subj['tchr']!,
        ),
        date,
      );
    } else {
      final subjM = weeklySubjects[idxBase];
      final slotM = morningSlots[date.weekday % morningSlots.length];
      addEventToCalendar(
        createLessonEvent(
          title: '${subjM['name']} Class',
          subject: subjM['name']!,
          startTime: slotM['start']!,
          endTime: slotM['end']!,
          room: subjM['romm']!,
          building: subjM['bdng']!,
          teacher: subjM['tchr']!,
        ),
        date,
      );
      final subjA = weeklySubjects[(idxBase + 3) % weeklySubjects.length];
      final slotA = afternoonSlots[date.weekday % afternoonSlots.length];
      addEventToCalendar(
        createLessonEvent(
          title: '${subjA['name']} Class',
          subject: subjA['name']!,
          startTime: slotA['start']!,
          endTime: slotA['end']!,
          room: subjA['romm']!,
          building: subjA['bdng']!,
          teacher: subjA['tchr']!,
        ),
        date,
      );
    }
  }

  for (var i = 0; i < monthlySubjects.length; i++) {
    final subj = monthlySubjects[i];
    for (var m = 0;; m++) {
      final monthDate = DateTime(kFirstDay.year, kFirstDay.month + m, 1);
      if (monthDate.isAfter(kLastDay)) break;
      final daysInMonth = DateTime(monthDate.year, monthDate.month + 1, 0).day;
      final day = [5, 10, 15, 20, 25, daysInMonth][i];
      var date = DateTime(monthDate.year, monthDate.month, day);
      if (date.isBefore(kFirstDay) || date.isAfter(kLastDay)) continue;
      if (date.weekday == DateTime.sunday) {
        date = date.add(Duration(days: 1)); // shift to Monday
      }
      addEventToCalendar(
        createLessonEvent(
          title: '${subj['name']} Session',
          subject: subj['name']!,
          startTime: '15:35',
          endTime: '16:55',
          room: subj['romm']!,
          building: subj['bdng']!,
          teacher: subj['tchr']!,
        ),
        date,
      );
    }
  }
  await saveEventsToFile();
}

Future<void> initCalendarEvents() async {
  kEvents.clear();
  await loadEventsFromFile();
  if (kEvents.isEmpty) {
    await populateStudentSchedule();
  }
}