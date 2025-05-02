import 'package:flutter/material.dart';
// Import trang Home
// Import trang Search
// Import trang Notification
//import 'Pages/Profile/profile.dart'; // Import trang Profile
import 'Pages/Login/LoginPage.dart'; // Import trang Login


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 254, 247, 255),
      ),
      home: LoginPage(),
    );
  }
}
