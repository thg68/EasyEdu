import 'dart:collection';

//import 'dart:math';
import 'package:table_calendar/table_calendar.dart';

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

  @override
  String toString() => title;
}

// List of subjects with icons
final subjects = [
  {
    "name": "Đại Số",
    "tchr": "Trần Thanh Hoa",
    "romm": "P301",
    "bdng": "C2",
    "icon": "assets/images/Algebra_icon.png"
  },
  {
    "name": "Giải Tích",
    "tchr": "Lê Minh Tuấn",
    "romm": "P302",
    "bdng": "C2",
    "icon": "assets/images/Geometry_icon.png"
  },
  {
    "name": "Ngữ Văn",
    "tchr": "Phạm Thị Lan",
    "romm": "P201",
    "bdng": "B1",
    "icon": "assets/images/Literature_icon.png"
  },
  {
    "name": "Tiếng Anh",
    "tchr": "Nguyễn Thị Lan Hạnh",
    "romm": "P202",
    "bdng": "B1",
    "icon": "assets/images/Spanish_icon.png"
  },
  {
    "name": "Vật Lý",
    "tchr": "Đỗ Văn Hùng",
    "romm": "P101",
    "bdng": "B2",
    "icon": "assets/images/Physics_icon.png"
  },
  {
    "name": "Hóa Học",
    "tchr": "Vũ Thu Thủy",
    "romm": "P102",
    "bdng": "B3",
    "icon": "assets/images/Chemistry_icon.png"
  },
  {
    "name": "Sinh Học",
    "tchr": "Hoàng Văn Nam",
    "romm": "P201",
    "bdng": "B2",
    "icon": "assets/images/Biology_icon.png"
  },
  {
    "name": "Lịch Sử",
    "tchr": "Bùi Kiều",
    "romm": "P104",
    "bdng": "B1",
    "icon": "assets/images/History_icon.png"
  },
  {
    "name": "Địa Lý",
    "tchr": "Phan Tiến Đức",
    "romm": "P106",
    "bdng": "B1",
    "icon": "assets/images/Geography_icon.png"
  },
  {
    "name": "Giáo Dục Công Dân",
    "tchr": "Trịnh Thị Mai",
    "romm": "P107",
    "bdng": "B1",
    "icon": "assets/images/Civics_icon.png"
  },
  {
    "name": "Tin Học",
    "tchr": "Trần Quốc Sơn",
    "romm": "PM203",
    "bdng": "Tech",
    "icon": "assets/images/Computer_Science_icon.png"
  },
  {
    "name": "Công Nghệ",
    "tchr": "Lê Thị Thanh Phương",
    "romm": "PM202",
    "bdng": "Tech",
    "icon": "assets/images/Technology_icon.png"
  },
  {
    "name": "Giáo Dục Thể Chất",
    "tchr": "Nguyễn Đưc Bình",
    "romm": "Sân cỏ",
    "bdng": "Sân cỏ",
    "icon": "assets/images/Physical_Education_icon.png"
  },
  {
    "name": "Kinh Tế và Pháp Luật",
    "tchr": "Phạm Mai An",
    "romm": "P301",
    "bdng": "B1",
    "icon": "assets/images/Economics_icon.png"
  },
  {
    "name": "Mỹ Thuật",
    "tchr": "Võ Huyền Ngọc",
    "romm": "P202",
    "bdng": "C1",
    "icon": "assets/images/Arts_icon.png"
  },
  {
    "name": "Âm Nhạc",
    "tchr": "Nguyễn Thị Ly",
    "romm": "P201",
    "bdng": "C1",
    "icon": "assets/images/Music_icon.png"
  },
  {
    "name": "Tư Duy Phản Biện",
    "tchr": "Hoàng Thị Hạnh",
    "romm": "R202",
    "bdng": "B2",
    "icon": "assets/images/Drama_icon.png"
  },
  {
    "name": "Trải Nghiệm Hướng Việc",
    "tchr": "Lê Văn Quang",
    "romm": "P302",
    "bdng": "C3",
    "icon": "assets/images/Career_icon.png"
  },
  {
    "name": "Giáo Dục Quốc Phòng",
    "tchr": "Đặng Thị Ban Oanh",
    "romm": "Sân cỏ",
    "bdng": "Hola",
    "icon": "assets/images/Military_icon.png"
  },
  {
    "name": "Giáo Dục Đặc Biệt",
    "tchr": "Phan Thị Lan",
    "romm": "P103",
    "bdng": "B3",
    "icon": "assets/images/Special_Education_icon.png"
  }
];

void addEventToCalendar(Event event, DateTime date) {
  final eventDate = DateTime.utc(date.year, date.month, date.day);
  if (kEvents.containsKey(eventDate)) {
    kEvents[eventDate]!.add(event);
  } else {
    kEvents[eventDate] = [event];
  }
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

void populateStudentSchedule() {
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

  // Weekly: rotating schedule
  final allDays = daysInRange(kFirstDay, kLastDay);
  for (var date in allDays) {
    if (date.weekday == DateTime.sunday) continue;
    final idxBase = date.difference(kFirstDay).inDays % weeklySubjects.length;

    if (date.weekday == DateTime.saturday) {
      // Saturday: one morning
      final subj = weeklySubjects[idxBase];
      final slot = morningSlots[0];
      addEventToCalendar(
        createLessonEvent(
          title: 'Lớp ${subj['name']}',
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
      // Weekday: one morning, one afternoon
      final subjM = weeklySubjects[idxBase];
      final slotM = morningSlots[date.weekday % morningSlots.length];
      addEventToCalendar(
        createLessonEvent(
          title: 'Lớp ${subjM['name']}',
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
          title: 'Lớp ${subjA['name']}',
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

  // Monthly: spread on days 5, 10, 15, 20, 25, last day
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
}

void initCalendarEvents() {
  kEvents.clear();
  populateStudentSchedule();
}

