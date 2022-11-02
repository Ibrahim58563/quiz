import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:math' as math;

class HeaderAnimation extends StatefulWidget {
  const HeaderAnimation({super.key});

  @override
  State<HeaderAnimation> createState() => _HeaderAnimationState();
}

class _HeaderAnimationState extends State<HeaderAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: Duration(seconds: 25),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (_controller!.value == 0.8) _controller!.reverse();
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller!,
          builder: (BuildContext context, Widget? child) {
            return ClipPath(
              clipper: DrawClip(_controller!.value),
              child: Container(
                height: size.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [Color(0xFFE0647B), Color(0xFFFCDD89)]),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

Widget input(String hint, {bool isPass = false}) {
  return TextField(
    obscureText: isPass,
    decoration: InputDecoration(
        hintText: 'Nick name or email',
        hintStyle: TextStyle(color: Color(0xFFACACAC), fontSize: 14),
        contentPadding: EdgeInsets.only(top: 20, bottom: 20, left: 38),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFF1F1F1)),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFC7C7C7)),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        )),
  );
}

class DrawClip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  DrawClip(this.move);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    double xCenter =
        size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);
    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
