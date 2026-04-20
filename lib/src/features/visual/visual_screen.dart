import 'package:flutter/material.dart';

import '../../core/theme/move_theme.dart';
import '../../core/widgets/app_scaffold_shell.dart';
import '../../core/widgets/glow_card.dart';
import '../../core/widgets/section_title.dart';
import 'notifications_screen.dart';
import 'statusbar_screen.dart';

class VisualScreen extends StatelessWidget {
  const VisualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldShell(
      title: 'Visual',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 120),
        children: [
          const SectionTitle('Customization Areas'),
          const SizedBox(height: 12),
          _VisualCard(
            title: 'Status Bar',
            subtitle: 'Clock • Battery • Network • Icons',
            icon: Icons.space_dashboard_outlined,
            color: MoveTheme.secondary,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const StatusbarScreen())),
          ),
          _VisualCard(
            title: 'Notifications',
            subtitle: 'Sound • Overlay • Blur • Behavior',
            icon: Icons.notifications_active_outlined,
            color: MoveTheme.danger,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NotificationsScreen())),
          ),
          const _VisualCard(title: 'QS Panel', subtitle: 'Tiles • Slider • Blur • Media', icon: Icons.dashboard_customize_outlined, color: MoveTheme.primary),
          const _VisualCard(title: 'Lockscreen', subtitle: 'Clock • Charging • Shortcuts', icon: Icons.lock_outline_rounded, color: MoveTheme.success),
          const _VisualCard(title: 'Themes', subtitle: 'Accent • Fonts • Glow • Presets', icon: Icons.auto_awesome_outlined, color: MoveTheme.warning),
        ],
      ),
    );
  }
}

class _VisualCard extends StatelessWidget {
  const _VisualCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      onTap: onTap,
      color: color,
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Color(0xFFA9AFCA))),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Colors.white54),
        ],
      ),
    );
  }
}
