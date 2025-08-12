import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(YonoApp());
}

class YonoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(0.8),
          ),
          child: child!,
        );
      },
      title: 'YONO SBI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
