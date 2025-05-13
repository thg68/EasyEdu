import 'package:flutter/material.dart';
import '../DetailPages/DetailPage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<String> allSubjects = [
    'Giải Tích',
    'Đại Số',
    'Ngữ Văn',
    'Lịch Sử',
    'Địa Lý',
    'Vật Lý',
    'Hóa Học',
    'Sinh Học',
    'Tiếng Anh',
    'Tin Học',
  ];

  List<String> filteredResults = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ban đầu chỉ hiển thị 3 môn
    filteredResults = allSubjects.take(3).toList();

    // Theo dõi thay đổi trong TextField để xử lý trường hợp người dùng xóa hết text
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          filteredResults = allSubjects.take(3).toList();
        });
      }
    });
  }

  void _filterResults(String query) {
    if (query.isEmpty) {
      // Nếu rỗng thì hiển thị lại 3 môn đầu tiên
      setState(() {
        filteredResults = allSubjects.take(3).toList();
      });
    } else {
      final results = allSubjects.where((subject) {
        return subject.toLowerCase().contains(query.toLowerCase());
      }).toList();

      setState(() {
        filteredResults = results;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Tìm Kiếm',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: const [SizedBox(width: kToolbarHeight / 2)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Search box
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.purple.shade100, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterResults,
                decoration: const InputDecoration(
                  hintText: 'Nhập từ khóa...',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 18),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Result list
            Expanded(
              child: filteredResults.isEmpty
                  ? const Center(child: Text('Không tìm thấy kết quả'))
                  : ListView.separated(
                      itemCount: filteredResults.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return buildResultItem(context, filteredResults[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResultItem(BuildContext context, String title) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(title: title)),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.purple.shade100, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.deepPurple),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
