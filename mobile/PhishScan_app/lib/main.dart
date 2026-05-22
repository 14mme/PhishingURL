import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const PhishScanApp());
}

class PhishScanApp extends StatelessWidget {
  const PhishScanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'PhishScan',

      theme: ThemeData.dark(),

      home: const HomeScreen(),
    );
  }
}