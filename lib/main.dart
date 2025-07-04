import 'package:flutter/material.dart';
import 'pages/pin_page.dart';

void main() {
  runApp(const NextMeApp());
}

class NextMeApp extends StatelessWidget {
  const NextMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NextMe',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData.light(useMaterial3: true), // Optional: enable Material 3
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const PinPage()
    );
  }
}
