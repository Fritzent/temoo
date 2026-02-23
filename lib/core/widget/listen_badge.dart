import 'package:flutter/material.dart';
import 'package:tere_mood/core/theme/app_theme.dart';
import 'package:tere_mood/l10n/app_localizations.dart';

class ListeningBadge extends StatefulWidget {
  const ListeningBadge({super.key, required this.isListening});

  final bool isListening;

  @override
  State<ListeningBadge> createState() => _ListeningBadgeState();
}

class _ListeningBadgeState extends State<ListeningBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;
  late AppLocalizations appLocalizations;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _blinkAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _blinkController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context)!;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppTheme.softPink,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _blinkAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: widget.isListening ? _blinkAnimation.value : 1.0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color : widget.isListening ? AppTheme.idleBadgeColor : AppTheme.activeBadgeColor,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 6),
          Text(
            widget.isListening ? appLocalizations.textIdle : appLocalizations.textListening,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: AppTheme.pink,
            ),
          ),
        ],
      ),
    );
  }
}