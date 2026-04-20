import 'package:flutter/material.dart';

import '../theme/move_theme.dart';

class GlowCard extends StatelessWidget {
  const GlowCard({
    super.key,
    this.onTap,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.color = MoveTheme.primary,
    this.margin,
  });

  final VoidCallback? onTap;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF111111), Color(0xFF080808)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: color.withValues(alpha: 0.42)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.10),
            blurRadius: 28,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );

    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: card,
      ),
    );
  }
}
