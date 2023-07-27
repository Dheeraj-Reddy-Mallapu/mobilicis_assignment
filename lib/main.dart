import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'const_colors.dart';
import 'screens/home screen/home_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor), // ~Indigo Color
      ),
      home: const HomeScreen(),
    );
  }
}
