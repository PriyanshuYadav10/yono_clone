import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yono/screens/homescreen_first.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
   AnimationController? _controller;
   Animation<double>? _rippleAnimation;
   bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,     
      duration: const Duration(seconds: 5),
    )..repeat(reverse: false);

    _rippleAnimation = Tween<double>(begin: 0, end: 400).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.easeOut,),
    );
      Timer(const Duration(seconds: 5 ), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomescreenFirst()),
      );
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isVisible = true;
        });
      }
    });

  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Gradient background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFFFB0C67), // pinkish red
                    Color(0xFFCE1FB3), // magenta
                    Color(0xFF6C00CB), // violet/purple (top right)
                  ],
                  stops: [0.0, 0.7, 1.0], // controls how much space each color takes

                ),
              ),
            ),
            
            // Ripple splash effect behind
            Center(
              child: AnimatedBuilder(
                animation: _rippleAnimation!,
                builder: (context, child) {
                  return Container(
                    width: _rippleAnimation?.value,
                    height: _rippleAnimation?.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.08),
                    ),
                  );
                },
              ),
            ),
            
            // Center layered circular logo
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _isVisible ?  Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ) : SizedBox(),
                  _isVisible ?  Container(
                    width: 360,
                    height: 360,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ) : SizedBox(),
                  _isVisible ?  Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ) : SizedBox(),
                  _isVisible ?  Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ) : SizedBox(),
                  _isVisible ? Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ) : SizedBox(),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Bottom curved white container with text
            _isVisible ? Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: BottomCurveClipper(),
                child: Container(
                  height: size.height * 0.18,
                  color: Colors.white,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(bottom: size.height * 0.050),
                  child: const Text(
                    'Banking · Payments · Lifestyle',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ),
            ) : SizedBox(),
          ],
        ),
      ),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 80);
    path.quadraticBezierTo(
      size.width / 2,
      0,
      size.width,
      80,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
