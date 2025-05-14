import 'package:flutter/material.dart';
import '../../Utils/event.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<Event> _upcomingEvents;

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() {
    final now = DateTime.now();
    final endDate = now.add(const Duration(days: 100));

    List<Event> events = [];
    for (DateTime date = now;
        date.isBefore(endDate);
        date = date.add(const Duration(days: 1))) {
      final dayEvents = kEvents[date] ?? [];
      events.addAll(dayEvents);
    }

    events.sort((a, b) {
      final aDate = _getDateFromEvent(a);
      final bDate = _getDateFromEvent(b);

      if (aDate != bDate) {
        return aDate.compareTo(bDate);
      }

      final aTime = a.startTime ?? '00:00';
      final bTime = b.startTime ?? '00:00';
      return aTime.compareTo(bTime);
    });

    setState(() {
      _upcomingEvents = events.toSet().toList();
    });
  }

  DateTime _getDateFromEvent(Event event) {
    final eventDays = kEvents.entries
        .where((entry) => entry.value.contains(event))
        .map((entry) => entry.key)
        .toList();

    return eventDays.isNotEmpty ? eventDays.first : DateTime.now();
  }

  String _formatEventDate(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Hôm Nay';
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Ngày Mai';
    }

    final List<String> weekdays = [
      'Thứ Hai',
      'Thứ Ba',
      'Thứ Tư',
      'Thứ Năm',
      'Thứ Sáu',
      'Thứ Bảy',
      'Chủ Nhật',
    ];
    final List<String> months = [
      'Tháng 1',
      'Tháng 2',
      'Tháng 3',
      'Tháng 4',
      'Tháng 5',
      'Tháng 6',
      'Tháng 7',
      'Tháng 8',
      'Tháng 9',
      'Tháng 10',
      'Tháng 11',
      'Tháng 12',
    ];

    return '${weekdays[date.weekday - 1]}, Ngày ${date.day} ${months[date.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông báo',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadEvents),
        ],
      ),
      body: _upcomingEvents.isEmpty
          ? const Center(child: Text('Không có sự kiện nào?'))
          : ListView.builder(
              itemCount: _upcomingEvents.length,
              itemBuilder: (context, index) {
                final event = _upcomingEvents[index];
                final eventDate = _getDateFromEvent(event);
                final formattedDate = _formatEventDate(eventDate);
                final bool showDateHeader = index == 0 ||
                    _getDateFromEvent(_upcomingEvents[index - 1]) != eventDate;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showDateHeader)
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          top: 16.0,
                          bottom: 8.0,
                        ),
                        child: Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 4.0,
                      ),
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(
                          color: _getEventColor(event),
                          width: 1.5,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: _getEventColor(
                              event,
                            ).withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              _getEventIcon(event),
                              color: _getEventColor(event),
                            ),
                          ),
                        ),
                        title: Text(
                          event.subject != null
                              ? '${event.subject}'
                              : event.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            if (event.timeRange.isNotEmpty)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    event.timeRange,
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            if (event.location.isNotEmpty)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    event.location,
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            if (event.teacher != null)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    size: 14,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    event.teacher!,
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Đã đặt nhắc nhở cho môn này',
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
                        onTap: () {
                          _showEventDetails(context, event, eventDate);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  Color _getEventColor(Event event) {
    if (event.subject == null) return Colors.white10;

    final subject = event.subject!.toLowerCase();

    if (subject.contains('đại số')) return Colors.blue;
    if (subject.contains('giải tích')) return Colors.cyan;
    if (subject.contains('ngữ văn')) return Colors.green;
    if (subject.contains('tiếng anh')) return Colors.deepPurple;
    if (subject.contains('vật lý')) return Colors.teal;
    if (subject.contains('hóa học')) return Colors.orange;
    if (subject.contains('sinh học')) return Colors.pink;
    if (subject.contains('lịch sử')) return Colors.red;
    if (subject.contains('địa lý')) return Colors.purple;

    if (subject.contains('giáo dục công dân')) return Colors.amber;
    if (subject.contains('tin học')) return Colors.lightBlue;
    if (subject.contains('công nghệ')) return Colors.indigo;
    if (subject.contains('giáo dục thể chất')) return Colors.lime;
    if (subject.contains('kinh tế và pháp luật')) return Colors.deepOrange;
    if (subject.contains('mỹ thuật')) return Colors.purpleAccent;
    if (subject.contains('âm nhạc')) return Colors.lightGreen;
    if (subject.contains('tư duy phản biện')) return Colors.black54;
    if (subject.contains('trải nghiệm')) return Colors.grey;
    if (subject.contains('giáo dục quốc phòng') ||
        subject.contains('giáo dục đặc biệt')) {
      return Colors.brown;
    }

    return Colors.brown;
  }

  IconData _getEventIcon(Event event) {
    if (event.subject == null) return Icons.event;

    final subject = event.subject!.toLowerCase();

    if (subject.contains('đại số')) return Icons.calculate;
    if (subject.contains('giải tích')) return Icons.functions;
    if (subject.contains('ngữ văn')) return Icons.menu_book;
    if (subject.contains('tiếng anh')) return Icons.translate;
    if (subject.contains('vật lý')) return Icons.lightbulb_rounded;
    if (subject.contains('hóa học')) return Icons.science;
    if (subject.contains('sinh học')) return Icons.biotech;
    if (subject.contains('lịch sử')) return Icons.history_edu;
    if (subject.contains('địa lý')) return Icons.public;

    if (subject.contains('giáo dục công dân')) return Icons.gavel;
    if (subject.contains('tin học')) return Icons.computer;
    if (subject.contains('công nghệ')) return Icons.build;
    if (subject.contains('giáo dục thể chất')) return Icons.sports_soccer;
    if (subject.contains('kinh tế và pháp luật')) return Icons.account_balance;
    if (subject.contains('mỹ thuật')) return Icons.palette;
    if (subject.contains('âm nhạc')) return Icons.music_note;
    if (subject.contains('tư duy phản biện')) return Icons.psychology;
    if (subject.contains('trải nghiệm')) {
      return Icons.work_outline;
    }
    if (subject.contains('giáo dục quốc phòng')) return Icons.military_tech;
    if (subject.contains('giáo dục đặc biệt')) return Icons.accessibility;

    return Icons.event;
  }

  void _showEventDetails(
    BuildContext context,
    Event event,
    DateTime eventDate,
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
                    event.subject != null ? '${event.subject}' : event.title,
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
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text(_formatEventDate(eventDate)),
              ),
              if (event.timeRange.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.access_time),
                  title: Text(event.timeRange),
                ),
              if (event.location.isNotEmpty)
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(event.location),
                ),
              if (event.teacher != null)
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(event.teacher!),
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.notifications_active),
                    label: const Text('Đặt nhắc nhở'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getEventColor(event),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Đã đặt nhắc nhở cho ${event.title}'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.delete),
                    label: const Text('Xóa'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      await deleteEventFromCalendar(event, eventDate);
                      setState(() {});
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Đã xóa ${event.title}'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
