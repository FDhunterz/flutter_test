import 'package:flutter/material.dart';

class HomeNavigatorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Membuat Paint object untuk menggambar
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;
    double sizeExpand = 1.2;

    Path path = Path()..moveTo(0, size.height * .8);
    path.lineTo((size.width * .5) - 60, size.height * .8);
    path.quadraticBezierTo((size.width * .5) - (30 * sizeExpand), size.height * .79, (size.width * .5) - (30 * sizeExpand), (size.height * .8) + ((size.height - (size.height * .8)) * .6));
    path.quadraticBezierTo((size.width * .5) - (30 * sizeExpand), size.height, (size.width * .5) - (10 * sizeExpand), size.height);
    path.lineTo((size.width * .5) + (10 * sizeExpand), size.height);
    path.quadraticBezierTo((size.width * .5) + (30 * sizeExpand), size.height, (size.width * .5) + (30 * sizeExpand), (size.height * .8) + ((size.height - (size.height * .8)) * .6));
    path.quadraticBezierTo((size.width * .5) + (30 * sizeExpand), size.height * .8, (size.width * .5) + 60, size.height * .8);
    path.lineTo(size.width, size.height * .8);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class HomePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Membuat Paint object untuk menggambar
    Paint paint = Paint()
      ..color = const Color(0xffC1DDED)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    Path path = Path()..moveTo(size.width * .1, 0);
    path.lineTo(size.width * .1, (size.height * 0.2));
    path.quadraticBezierTo((size.width * .1), (size.height * 0.5) - 30, (size.width * .1) * .5, (size.height * 0.5) - 30);
    path.quadraticBezierTo(0, (size.height * 0.5) - 30, 0, (size.height * 0.5) - 20);
    path.lineTo(0, (size.height * 0.5) - 20);
    path.lineTo(0, (size.height * 0.5) + 20);
    path.quadraticBezierTo(0, (size.height * 0.5) + 30, (size.width * .1) * .5, (size.height * 0.5) + 30);
    path.quadraticBezierTo((size.width * .1), (size.height * 0.5) + 30, (size.width * .1), size.height * 0.8);
    path.lineTo(size.width * .1, (size.height * 0.8));
    path.lineTo(size.width * .1, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class HomeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Membuat Paint object untuk menggambar

    Path path = Path()..moveTo(size.width * .1, 0);
    path.lineTo(size.width * .1, (size.height * 0.2));
    path.quadraticBezierTo((size.width * .1), (size.height * 0.5) - 30, (size.width * .1) * .5, (size.height * 0.5) - 30);
    path.quadraticBezierTo(0, (size.height * 0.5) - 30, 0, (size.height * 0.5) - 10);
    path.lineTo(0, (size.height * 0.5) - 10);
    path.lineTo(0, (size.height * 0.5) + 10);
    path.quadraticBezierTo(0, (size.height * 0.5) + 30, (size.width * .1) * .5, (size.height * 0.5) + 30);
    path.quadraticBezierTo((size.width * .1), (size.height * 0.5) + 25, (size.width * .1), size.height * 0.8);
    path.lineTo(size.width * .1, (size.height * 0.8));
    path.lineTo(size.width * .1, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  const ClipShadowPath({
    super.key,
    required this.shadow,
    required this.clipper,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: clipper,
        shadow: shadow,
      ),
      child: ClipPath(clipper: clipper, child: child),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
