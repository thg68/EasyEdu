import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          theme: themeProvider.highContrast
              ? ThemeData.dark().copyWith(
                  scaffoldBackgroundColor: Colors.black,
                  textTheme: Theme.of(context)
                      .textTheme
                      .apply(
                        fontSizeFactor: themeProvider.fontSize / 16.0,
                        bodyColor: Colors.white,
                        displayColor: Colors.white,
                      )
                      .copyWith(
                        bodyLarge: TextStyle(
                          color: Colors.white,
                          fontWeight: themeProvider.boldText
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        bodyMedium: TextStyle(
                          color: Colors.white,
                          fontWeight: themeProvider.boldText
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        bodySmall: TextStyle(
                          color: Colors.white,
                          fontWeight: themeProvider.boldText
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        titleLarge: TextStyle(
                          color: Colors.white,
                          fontWeight: themeProvider.boldText
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        titleMedium: TextStyle(
                          color: Colors.white,
                          fontWeight: themeProvider.boldText
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        titleSmall: TextStyle(
                          color: Colors.white,
                          fontWeight: themeProvider.boldText
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  cardTheme: CardTheme(
                    color: Colors.black,
                    elevation: 2,
                  ),
                  dividerTheme: const DividerThemeData(
                    color: Colors.white,
                  ),
                )
              : ThemeData.light().copyWith(
                  scaffoldBackgroundColor:
                      const Color.fromARGB(255, 254, 247, 255),
                  textTheme: Theme.of(context)
                      .textTheme
                      .apply(
                        fontSizeFactor: themeProvider.fontSize / 16.0,
                      )
                      .copyWith(
                        bodyLarge: TextStyle(
                          color: themeProvider.textColor,
                          fontWeight: themeProvider.boldText
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        bodyMedium: TextStyle(
                          color: themeProvider.textColor,
                          fontWeight: themeProvider.boldText
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        bodySmall: TextStyle(
                          color: themeProvider.textColor,
                          fontWeight: themeProvider.boldText
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        titleLarge: TextStyle(
                          color: themeProvider.textColor,
                          fontWeight: themeProvider.boldText
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        titleMedium: TextStyle(
                          color: themeProvider.textColor,
                          fontWeight: themeProvider.boldText
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        titleSmall: TextStyle(
                          color: themeProvider.textColor,
                          fontWeight: themeProvider.boldText
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                ),
          home: LoginPage(),
        );
      },
    );
  }
}
