import 'package:flutter/material.dart';
import 'package:tere_mood/core/enum/snackbar_enum.dart';
import 'package:tere_mood/core/theme/app_theme.dart';

class _SnackConfig {
  final String emoji;
  final String message;
  final LinearGradient gradient;
  final Color closeColor;
  final int width;

  const _SnackConfig({
    required this.emoji,
    required this.message,
    required this.gradient,
    required this.closeColor,
    required this.width,
  });
}

_SnackConfig _getConfig(AvatarSnackBarType type, String message) {
  switch (type) {
    case AvatarSnackBarType.lovely:
      return _SnackConfig(
        emoji: '😎',
        message: message,
        gradient: const LinearGradient(
          colors: [AppTheme.pink, AppTheme.pink],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        closeColor: AppTheme.softPink,
        width: 400,
      );
    case AvatarSnackBarType.sad:
      return _SnackConfig(
        emoji: '😢',
        message: message,
        gradient: const LinearGradient(
          colors: [AppTheme.idleBadgeColor, AppTheme.idleBadgeColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        closeColor: AppTheme.softPink,
        width: 400,
      );
  }
}

class AvatarEmoticonSnackBar extends SnackBar {
  AvatarEmoticonSnackBar({
    super.key,
    required String message,
    required AvatarSnackBarType type,
    super.duration,
  }) : super(
          backgroundColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.zero,
          dismissDirection: DismissDirection.horizontal,
          content: _AvatarSnackContent(message: message, type: type),
        );
}

class _AvatarSnackContent extends StatefulWidget {
  final String message;
  final AvatarSnackBarType type;

  const _AvatarSnackContent({required this.message, required this.type});

  @override
  State<_AvatarSnackContent> createState() => _AvatarSnackContentState();
}

class _AvatarSnackContentState extends State<_AvatarSnackContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _slide = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(widget.type, widget.message);

    return SlideTransition(
      position: _slide,
      child: FadeTransition(
        opacity: _fade,
        child: Align(
          alignment: Alignment.centerLeft,
          child: UnconstrainedBox(
            child: Container(
              width: config.width.toDouble(),
              margin: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 24),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: config.gradient,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.darkBackground.withAlpha(20),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _EmojiAvatar(emoji: config.emoji),
            
                  const SizedBox(width: 14),
            
                  Expanded(
                    child: Text(
                      widget.message,
                      style: const TextStyle(
                        color: AppTheme.darkBackground,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
            
                  const SizedBox(width: 10),
            
                  GestureDetector(
                    onTap: () =>
                        ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: AppTheme.lightBackground,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmojiAvatar extends StatefulWidget {
  final String emoji;
  const _EmojiAvatar({required this.emoji});

  @override
  State<_EmojiAvatar> createState() => _EmojiAvatarState();
}

class _EmojiAvatarState extends State<_EmojiAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _pulse = Tween<double>(begin: 1.0, end: 1.08)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _pulse,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppTheme.pink,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Text(widget.emoji, style: const TextStyle(fontSize: 28)),
        ),
      ),
    );
  }
}

extension AvatarSnackBarX on BuildContext {
  void showAvatarSnackBar({
    required String message,
    required AvatarSnackBarType type,
    Duration duration = const Duration(seconds: 4),
  }) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        AvatarEmoticonSnackBar(message: message, type: type, duration: duration),
      );
  }
}