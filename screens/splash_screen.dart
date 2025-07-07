import 'package:flutter/material.dart';
import 'package:yono/screens/homescreen_first.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool showGradient = false;
  bool animationDone = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation =
        Tween<double>(begin: 0.0, end: 4.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        )..addStatusListener((status) {
  if (status == AnimationStatus.completed) {
    setState(() => animationDone = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 800),
          pageBuilder: (_, __, ___) => HomescreenFirst(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }
});


    Future.delayed(Duration(seconds: 2), () {
      setState(() => showGradient = true);
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Base gradient background
          if (animationDone)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF5B2A91), Color(0xFFD73C6B)],
                ),
              ),
            ),

          // Shrinking circular mask to reveal background
          if (showGradient && !animationDone)
            Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    width: MediaQuery.of(context).size.width * _animation.value,
                    height:
                        MediaQuery.of(context).size.height * _animation.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: Colors.white,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF5B2A91), Color(0xFFD73C6B)],
                      ),
                    ),
                  );
                },
              ),
            ),

          // Centered logo stays on top
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset('assets/logo.png', width: 200, height: 200),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
