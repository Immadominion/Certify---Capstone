// Custom painter to create overlay with transparent center
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OverlayPainter extends CustomPainter {
  final Color overlayColor;
  final double scannerWidth;
  final double scannerHeight;
  final double borderRadius;

  OverlayPainter({
    required this.overlayColor,
    required this.scannerWidth,
    required this.scannerHeight,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = overlayColor;

    final scannerLeft = (size.width - scannerWidth) / 2;
    final scannerTop = 105.h;
    final scannerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(scannerLeft, scannerTop, scannerWidth, scannerHeight),
      Radius.circular(borderRadius),
    );

    // Create path for entire screen
    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Cut out scanner area
    path.addRRect(scannerRect);

    // Set fillType to evenOdd to create a transparent window effect
    path.fillType = PathFillType.evenOdd;

    // Draw the overlay with the transparent center
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
