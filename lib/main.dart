import 'package:flutter/material.dart';
import 'package:flutter_workshop_ui_project/views/E01_page_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berry Juice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEB963A)),
      ),
      // E01PageUI เป็นหน้าจอแรก
      home: E01PageUI(),
    );
  }
}

