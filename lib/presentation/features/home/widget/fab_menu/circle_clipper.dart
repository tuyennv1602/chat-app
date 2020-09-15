import 'package:flutter/material.dart';

class CircleClipper extends CustomClipper<Path> {
  final Offset position;
  final Size icSize;
  final double padding;

  CircleClipper({
    this.position,
    this.icSize,
    this.padding = 0,
  });

  @override
  Path getClip(Size size) {
    final path1 = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();

    final dx = position.dx + icSize.width / 2;
    final dy = position.dy + icSize.height / 2;

    final rect = Rect.fromCircle(
      center: Offset(dx, dy),
      radius: icSize.width / 2 + padding,
    );
    final path2 = Path()
      ..arcTo(rect, 0, 3.14 * 2, false)
      ..close();

    final path3 = Path.combine(PathOperation.difference, path1, path2);

    return path3;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
