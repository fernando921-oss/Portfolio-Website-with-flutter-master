import 'package:flutter/material.dart';

class BlurBall extends StatelessWidget {
  final double size;
  final Color color;
  final Offset offset;

  const BlurBall({
    super.key,
    required this.size,
    required this.color,
    required this.offset,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // Main glow
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: size * 0.8,
              spreadRadius: size * 0.4,
            ),
          ],
          // Light core
          gradient: RadialGradient(
            colors: [
              color.withOpacity(0.45),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
