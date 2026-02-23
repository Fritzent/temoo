import 'package:flutter/material.dart';

class AvatarWidget extends StatefulWidget {
  const AvatarWidget({
    super.key,
    required this.isListening,
    this.avatarImageProvider,
  });

  final bool isListening;
  final ImageProvider? avatarImageProvider;

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: widget.isListening ? _pulseAnimation.value : 1.0,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFE8D5F5).withAlpha(102),
                  ),
                ),
              );
            },
          ),

          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: widget.isListening ? _scaleAnimation.value : 1.0,
                child: Container(
                  width: 170,
                  height: 170,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFDDD6F3),
                  ),
                  child: ClipOval(
                    child: _buildAvatarFace(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarFace() {
    if (widget.avatarImageProvider != null) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: Image(
          key: ValueKey(widget.avatarImageProvider),
          image: widget.avatarImageProvider!,
          width: 170,
          height: 170,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return CustomPaint(
              painter: _DeerAvatarPainter(),
              size: const Size(170, 170),
            );
          },
        ),
      );
    }

    return CustomPaint(
      painter: _DeerAvatarPainter(),
      size: const Size(170, 170),
    );
  }
}

class _DeerAvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2 + 10;

    final bodyPaint = Paint()..color = const Color(0xFFF2C4B8);
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(cx, cy + 30), width: 80, height: 55),
      bodyPaint,
    );

    final headPaint = Paint()..color = const Color(0xFFF2C4B8);
    canvas.drawCircle(Offset(cx, cy - 10), 46, headPaint);

    final earPath = Path();
    
    earPath.moveTo(cx - 30, cy - 45);
    earPath.quadraticBezierTo(cx - 52, cy - 80, cx - 22, cy - 55);
    
    earPath.moveTo(cx + 30, cy - 45);
    earPath.quadraticBezierTo(cx + 52, cy - 80, cx + 22, cy - 55);
    canvas.drawPath(earPath, headPaint);

    
    final innerEarPaint = Paint()..color = const Color(0xFFE8968A);
    final leftInnerEar = Path();
    leftInnerEar.moveTo(cx - 30, cy - 47);
    leftInnerEar.quadraticBezierTo(cx - 44, cy - 72, cx - 24, cy - 56);
    canvas.drawPath(leftInnerEar, innerEarPaint);

    final rightInnerEar = Path();
    rightInnerEar.moveTo(cx + 30, cy - 47);
    rightInnerEar.quadraticBezierTo(cx + 44, cy - 72, cx + 24, cy - 56);
    canvas.drawPath(rightInnerEar, innerEarPaint);

    final blushPaint = Paint()
      ..color = const Color(0xFFE88080).withAlpha(102);
    canvas.drawOval(
        Rect.fromCenter(center: Offset(cx - 28, cy + 2), width: 22, height: 14),
        blushPaint);
    canvas.drawOval(
        Rect.fromCenter(center: Offset(cx + 28, cy + 2), width: 22, height: 14),
        blushPaint);

    final eyeWhitePaint = Paint()..color = Colors.white;
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx - 16, cy - 12), width: 22, height: 24),
      eyeWhitePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + 16, cy - 12), width: 22, height: 24),
      eyeWhitePaint,
    );

    final irisPaint = Paint()..color = const Color(0xFF3D2314);
    canvas.drawCircle(Offset(cx - 16, cy - 11), 9, irisPaint);
    canvas.drawCircle(Offset(cx + 16, cy - 11), 9, irisPaint);

    final shinePaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(cx - 12, cy - 15), 3.5, shinePaint);
    canvas.drawCircle(Offset(cx + 20, cy - 15), 3.5, shinePaint);
    canvas.drawCircle(Offset(cx - 18, cy - 7), 1.8, shinePaint);
    canvas.drawCircle(Offset(cx + 14, cy - 7), 1.8, shinePaint);

    final nosePaint = Paint()..color = const Color(0xFFD47070);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, cy + 4), width: 10, height: 7),
      nosePaint,
    );

    final lashPaint = Paint()
      ..color = const Color(0xFF3D2314)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
        Offset(cx - 22, cy - 18), Offset(cx - 25, cy - 24), lashPaint);
    canvas.drawLine(
        Offset(cx - 16, cy - 22), Offset(cx - 17, cy - 28), lashPaint);
    canvas.drawLine(
        Offset(cx - 10, cy - 20), Offset(cx - 9, cy - 26), lashPaint);

    canvas.drawLine(
        Offset(cx + 22, cy - 18), Offset(cx + 25, cy - 24), lashPaint);
    canvas.drawLine(
        Offset(cx + 16, cy - 22), Offset(cx + 17, cy - 28), lashPaint);
    canvas.drawLine(
        Offset(cx + 10, cy - 20), Offset(cx + 9, cy - 26), lashPaint);

    final smilePaint = Paint()
      ..color = const Color(0xFFD47070)
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final smilePath = Path();
    smilePath.moveTo(cx - 7, cy + 12);
    smilePath.quadraticBezierTo(cx, cy + 18, cx + 7, cy + 12);
    canvas.drawPath(smilePath, smilePaint);
  }

  @override
  bool shouldRepaint(_DeerAvatarPainter oldDelegate) => false;
}