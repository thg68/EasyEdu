import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_edu/main.dart';

void main() {
  testWidgets('Hiển thị tiêu đề đúng', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Kiểm tra có tiêu đề "Bộ Tìm Kiếm"
    expect(find.text('Bộ Tìm Kiếm'), findsOneWidget);
  });

  testWidgets('Có thanh tìm kiếm', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Kiểm tra xem có TextField với hint "Từ khóa"
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Từ khóa'), findsOneWidget);
  });

  testWidgets('Có 4 icon trên thanh điều hướng', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Kiểm tra xem có 4 mục trong BottomNavigationBar
    expect(find.byType(BottomNavigationBarItem), findsNWidgets(4));
  });
}
