import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  final String name;
  final String userClass;
  final String? avatarUrl;

  const EditProfilePage({
    super.key,
    required this.name,
    required this.userClass,
    this.avatarUrl,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late String _selectedClass;
  File? _avatarFile;
  final List<String> _classes = [
    'Lớp 1',
    'Lớp 2',
    'Lớp 3',
    'Lớp 4',
    'Lớp 5',
    'Lớp 6',
    'Lớp 7',
    'Lớp 8',
    'Lớp 9',
    'Lớp 10',
    'Lớp 11',
    'Lớp 12',
    'Đại học',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _selectedClass = widget.userClass;
    if (widget.avatarUrl != null) {
      _avatarFile = File(widget.avatarUrl!);
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _avatarFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh sửa thông tin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              Navigator.pop(context, {
                'name': _nameController.text,
                'userClass': _selectedClass,
                'avatarFile': _avatarFile,
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _avatarFile != null
                    ? FileImage(_avatarFile!) as ImageProvider
                    : (widget.avatarUrl != null
                        ? FileImage(File(widget.avatarUrl!)) as ImageProvider
                        : const AssetImage('assets/images/profile_icon.png')),
                child: _avatarFile == null && widget.avatarUrl == null
                    ? const Icon(
                        Icons.camera_alt,
                        size: 30,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Họ và tên',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedClass,
                  items: _classes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedClass = newValue!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
