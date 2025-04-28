import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/Home/home.dart';
import 'Pages/Search/search.dart';
import 'Pages/Login/LoginPage.dart';
import 'Pages/Profile/ThemeProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  await themeProvider.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => themeProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: const Color.fromARGB(255, 254, 247, 255),
            textTheme: Theme.of(context).textTheme.apply(
                  fontSizeFactor: themeProvider.fontSize / 16.0,
                ),
            // Thêm cấu hình độ tương phản nếu cần
            brightness:
                themeProvider.highContrast ? Brightness.dark : Brightness.light,
          ),
          home: LoginPage(),
        );
      },
    );
  }
}
