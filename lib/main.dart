import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(YonoApp());
}

class YonoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YONO SBI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
