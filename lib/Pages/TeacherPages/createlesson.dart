import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

import '../../Utils/event.dart';

class CreateLessonPage extends StatefulWidget {
  const CreateLessonPage({super.key});

  @override
  State<CreateLessonPage> createState() => _CreateLessonPageState();
}

class _CreateLessonPageState extends State<CreateLessonPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _teacherController = TextEditingController();

  String _selectedLessonType = 'Bài giảng';
  String _selectedLessonForm = 'Học trên lớp';
  final List<String> _attachments = [];

  DateTime? _startDateTime;
  DateTime? _endDateTime;

  final List<String> _lessonTypes = [
    'Bài giảng',
    'Bài kiểm tra',
    'Kiểm tra nhanh',
    'Bài tập',
    'Bài tập nhóm',
    'Bài thực nghiệm',
    'Thảo luận',
  ];
  final List<String> _lessonForms = [
    'Học trên lớp',
    'Học online',
    'Học kết hợp',
    'Tự học',
    'Khác',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _subjectController.dispose();
    _classController.dispose();
    _descriptionController.dispose();
    _contentController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _roomController.dispose();
    _buildingController.dispose();
    _teacherController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller, {
    bool isStartDate = true,
  }) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (pickedDate == null) return;

    if (!context.mounted) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return;

    if (!mounted) return;

    final DateTime combined = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      controller.text = DateFormat('dd/MM/yyyy HH:mm').format(combined);
      if (isStartDate) {
        _startDateTime = combined;
      } else {
        _endDateTime = combined;
      }
    });
  }

  Future<void> _addAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _attachments.addAll(result.files.map((file) => file.name).toList());
      });
    }
  }

  void _removeAttachment(int index) {
    setState(() {
      _attachments.removeAt(index);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_startDateTime != null) {
        final startTimeStr = DateFormat('HH:mm').format(_startDateTime!);
        final endTimeStr = _endDateTime != null
            ? DateFormat('HH:mm').format(_endDateTime!)
            : DateFormat(
          'HH:mm',
        ).format(_startDateTime!.add(const Duration(hours: 1)));

        final eventDate = DateTime.utc(
          _startDateTime!.year,
          _startDateTime!.month,
          _startDateTime!.day,
        );

        final newEvent = Event(
          title: "$_selectedLessonType: ${_nameController.text}",
          startTime: startTimeStr,
          endTime: endTimeStr,
          room: _roomController.text.isNotEmpty ? _roomController.text : null,
          building: _buildingController.text.isNotEmpty
              ? _buildingController.text
              : null,
          subject: _subjectController.text,
          teacher: _teacherController.text.isNotEmpty
              ? _teacherController.text
              : null,
        );

        if (kEvents.containsKey(eventDate)) {
          kEvents[eventDate]!.add(newEvent);
        } else {
          kEvents[eventDate] = [newEvent];
        }
        saveEventsToFile();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đã tạo bài và thêm vào lịch học!'),
          ),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Chưa chọn thời gian của bài')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo bài học'),
        backgroundColor: const Color(0xFFE8DEF8),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Tên của bài học *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Chưa có tên bài học';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Môn học *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Chưa có tên bài học';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _classController,
                decoration: const InputDecoration(
                  labelText: 'Lớp *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Chưa có tên lớp';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedLessonType,
                decoration: const InputDecoration(
                  labelText: 'Loại bài học *',
                  border: OutlineInputBorder(),
                ),
                items:
                    _lessonTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedLessonType = newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedLessonForm,
                decoration: const InputDecoration(
                  labelText: 'Kiểu bài học *',
                  border: OutlineInputBorder(),
                ),
                items:
                    _lessonForms.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedLessonForm = newValue;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(
                  labelText: 'Ngày giờ bắt đầu *',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(
                      context,
                      _startDateController,
                      isStartDate: true,
                    ),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Chưa có ngày và giờ bắt đầu';
                  }
                  return null;
                },
                onTap: () => _selectDate(
                  context,
                  _startDateController,
                  isStartDate: true,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(
                  labelText: 'Ngày giờ kết thúc *',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(
                      context,
                      _endDateController,
                      isStartDate: false,
                    ),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Chưa có ngày và giờ kết thúc';
                  }
                  return null;
                },
                onTap: () => _selectDate(
                  context,
                  _endDateController,
                  isStartDate: false,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _roomController,
                      decoration: const InputDecoration(
                        labelText: 'Phòng học',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _buildingController,
                      decoration: const InputDecoration(
                        labelText: 'Toàn nhà',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _teacherController,
                decoration: const InputDecoration(
                  labelText: 'Tên giáo viên',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Mô tả',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Nội dung bài học *',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Chưa có nội dung bài học';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tệp đính kèm',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _attachments.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.attach_file),
                        title: Text(_attachments[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeAttachment(index),
                        ),
                      );
                    },
                  ),
                  ElevatedButton.icon(
                    onPressed: _addAttachment,
                    icon: const Icon(Icons.add),
                    label: const Text('Thêm tệp đính kèm'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE8DEF8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mục tiêu bài học',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              _nameController.text.isNotEmpty &&
                      _subjectController.text.isNotEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 20),
                        CalendarEventPreview(
                          title:
                              "$_selectedLessonType: ${_nameController.text}",
                          subject: _subjectController.text,
                          startTime: _startDateTime != null
                              ? DateFormat('HH:mm').format(_startDateTime!)
                              : null,
                          endTime: _endDateTime != null
                              ? DateFormat('HH:mm').format(_endDateTime!)
                              : null,
                          room: _roomController.text.isEmpty
                              ? null
                              : _roomController.text,
                          building: _buildingController.text.isEmpty
                              ? null
                              : _buildingController.text,
                          teacher: _teacherController.text.isEmpty
                              ? null
                              : _teacherController.text,
                        ),
                        const SizedBox(height: 20),
                      ],
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE8DEF8),
                  ),
                  child: const Text(
                    'Tạo bài học',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarEventPreview extends StatelessWidget {
  final String title;
  final String subject;
  final String? startTime;
  final String? endTime;
  final String? room;
  final String? building;
  final String? teacher;

  const CalendarEventPreview({
    super.key,
    required this.title,
    required this.subject,
    this.startTime,
    this.endTime,
    this.room,
    this.building,
    this.teacher,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Preview:",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.purple[800],
            ),
          ),
          const Divider(),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(Icons.subject, size: 16),
              const SizedBox(width: 5),
              Text(subject, style: const TextStyle(fontSize: 14)),
            ],
          ),
          if (startTime != null && endTime != null)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  const Icon(Icons.access_time, size: 16),
                  const SizedBox(width: 5),
                  Text(
                    "$startTime - $endTime",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          if (room != null || building != null)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  const Icon(Icons.location_on, size: 16),
                  const SizedBox(width: 5),
                  Text(
                    [room, building].where((e) => e != null).join(' - '),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          if (teacher != null)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  const Icon(Icons.person, size: 16),
                  const SizedBox(width: 5),
                  Text(teacher!, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
