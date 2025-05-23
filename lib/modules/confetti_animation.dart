import 'dart:math';
import 'package:flutter/material.dart';

class ConfettiParticle {
  Offset position;
  double size;
  Color color;
  double rotation;
  Offset velocity;

  ConfettiParticle({
    required this.position,
    required this.size,
    required this.color,
    required this.rotation,
    required this.velocity,
  });
}

class ConfettiWidget extends StatefulWidget {
  final int numberOfParticles;

  // Number of confeti particles.
  const ConfettiWidget({Key? key, this.numberOfParticles = 100}) : super(key: key);

  @override
  _ConfettiWidgetState createState() => _ConfettiWidgetState();
}

class _ConfettiWidgetState extends State<ConfettiWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late List<ConfettiParticle> particles;
  final Random random = Random();

  @override
  void initState() {
    super.initState();

    particles = List.generate(widget.numberOfParticles, (index) {
      return ConfettiParticle(
        position: Offset(0, 0),
        size: random.nextDouble() * 6 + 4, // Confetti particles Size.
        // Confetti colors.
        color: Colors.primaries[random.nextInt(Colors.primaries.length)],
        rotation: random.nextDouble() * 2 * pi,
        // Confetti locations.
        velocity: Offset(
          (random.nextDouble() - 0.5) * 500,
          (random.nextDouble() - 1) * 500,
        ),
      );
    });

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Animation time
    )..addListener(() {
      setState(() {
        final dt = controller.value;

        for (var p in particles) {
          // Which position on landing.
          p.position = Offset(
            p.velocity.dx * dt,
            p.velocity.dy * dt + 300 * dt * dt,
          );
          p.rotation += 0.1;
        }
      });
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ConfettiPainter(particles),
      size: Size.infinite,
    );
  }
}

class ConfettiPainter extends CustomPainter {
  final List<ConfettiParticle> particles;

  ConfettiPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Particle shape.
    for (var p in particles) {
      paint.color = p.color;
      canvas.save();
      canvas.translate(p.position.dx + size.width / 2, p.position.dy + size.height / 3);
      canvas.rotate(p.rotation);
      canvas.drawRect(Rect.fromLTWH(-p.size / 2, -p.size / 2, p.size, p.size), paint);
      canvas.restore();
    }
  }

  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
