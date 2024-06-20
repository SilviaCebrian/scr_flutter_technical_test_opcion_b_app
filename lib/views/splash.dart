import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatefulWidget {
  static const name = "splash";
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late AnimationController controller;
  late Color themeColor;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    themeColor = Theme.of(context).primaryColor;
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: FadeInLeft(
            duration: const Duration(seconds: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon(seconds: 1, icon: Icons.interests_rounded),
                icon(seconds: 2, icon: Icons.rocket, rotate: true),
                icon(seconds: 3, icon: Icons.star, sendToHome: true)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget icon(
      {required int seconds,
      required IconData icon,
      bool rotate = false,
      bool sendToHome = false}) {
    const double iconSize = 40;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Pulse(
        delay: Duration(seconds: seconds),
        onFinish: sendToHome ? (direction) => context.go("/home") : null,
        child: Transform.rotate(
          angle: rotate ? 70 : 0,
          child: Icon(
            icon,
            shadows: [
              BoxShadow(color: themeColor.withAlpha(80), blurRadius: 5.0),
            ],
            size: iconSize,
            color: themeColor,
          ),
        ),
      ),
    );
  }
}
