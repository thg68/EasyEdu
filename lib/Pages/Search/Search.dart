import 'package:flutter/material.dart';
import '../DetailPages/DetailPage.dart'; // Import DetailPage

class SearchPage extends StatelessWidget {
  final List<String> searchResults = [
    'Giải Tích',
    'Đại Số',
    'Ngữ Văn',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F4FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Tìm Kiếm',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          SizedBox(
              width:
                  kToolbarHeight / 2), // thêm 1 SizedBox nhỏ cân lại nút Back
        ],
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
                decoration: InputDecoration(
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
              child: ListView.separated(
                itemCount: searchResults.length,
                separatorBuilder: (context, index) => SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return buildResultItem(context, searchResults[index]);
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
        // Chuyển sang trang chi tiết
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(title: title)),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.purple.shade100, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.deepPurple),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}