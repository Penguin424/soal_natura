import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soal_natura/src/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          activeIndicatorBorder: const BorderSide(
            color: Colors.black,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          labelStyle: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0XFF97B446),
          onPrimary: Colors.white,
          background: const Color(0XFFC9D862),
          onBackground: Colors.black,
          secondary: const Color(0XFF535E26),
          onSecondary: Colors.white,
          error: Colors.black,
          onError: Colors.white,
          surface: const Color(0XFFC9D862),
          onSurface: Colors.black,
          brightness: Brightness.light,
        ),
      ),
      title: 'Material App',
      initialRoute: "/login",
      routes: {
        "/login": (context) => const LoginScreen(),
      },
    );
  }
}
