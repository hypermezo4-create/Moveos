import 'package:flutter/material.dart';

import '../../../core/theme/move_theme.dart';
import '../../../core/widgets/action_chip_button.dart';
import '../../../core/widgets/glow_card.dart';
import '../../../core/widgets/section_title.dart';
import '../../../core/widgets/status_badge.dart';
import '../../plugins/plugins_screen.dart';
import '../../security/security_screen.dart';
import '../../system/system_screen.dart';
import '../../visual/notifications_screen.dart';
import '../../visual/statusbar_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 140),
      children: [
        GlowCard(
          color: MoveTheme.secondary,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  'assets/branding/moveos_logo.png',
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Redmi Note 13 Pro Plus', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                    SizedBox(height: 6),
                    Text('Android 14 • MoveOS v7.1', style: TextStyle(color: Color(0xFFAFB4CF))),
                    SizedBox(height: 10),
                    StatusBadge(label: 'BUILD MU-7.1-2026.06.01', color: MoveTheme.secondary),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const SectionTitle('Quick Actions'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: const [
            ActionChipButton(icon: Icons.refresh_rounded, label: 'Refresh Statusbar', color: MoveTheme.primary),
            ActionChipButton(icon: Icons.memory_rounded, label: 'Restart SystemUI', color: MoveTheme.secondary),
            ActionChipButton(icon: Icons.shield_moon_outlined, label: 'Safe Mode', color: MoveTheme.warning),
            ActionChipButton(icon: Icons.backup_table_outlined, label: 'Backup', color: MoveTheme.success),
          ],
        ),
        const SizedBox(height: 24),
        const SectionTitle('Core Modules'),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.18,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _ModuleCard(
              title: 'System',
              subtitle: 'Framework • Keys • Broadcasts',
              icon: Icons.memory_rounded,
              color: MoveTheme.primary,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SystemScreen())),
            ),
            _ModuleCard(
              title: 'Status Bar',
              subtitle: 'Clock • Battery • Icons',
              icon: Icons.space_dashboard_outlined,
              color: MoveTheme.secondary,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const StatusbarScreen())),
            ),
            _ModuleCard(
              title: 'Notifications',
              subtitle: 'Overlay • Sound • Style',
              icon: Icons.notifications_active_outlined,
              color: MoveTheme.danger,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NotificationsScreen())),
            ),
            _ModuleCard(
              title: 'Plugins',
              subtitle: 'Verified • Internal • Experimental',
              icon: Icons.extension_outlined,
              color: MoveTheme.success,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PluginsScreen())),
            ),
            _ModuleCard(
              title: 'Integrity',
              subtitle: 'Trust • Scan • Protection',
              icon: Icons.verified_user_outlined,
              color: MoveTheme.warning,
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SecurityScreen())),
            ),
            const _ModuleCard(
              title: 'Gaming',
              subtitle: 'Booster • Profiles • Sidebar',
              icon: Icons.sports_esports_outlined,
              color: MoveTheme.primary,
            ),
          ],
        ),
        const SizedBox(height: 24),
        const SectionTitle('Recent Changes'),
        const SizedBox(height: 12),
        const _RecentChange(title: 'Statusbar updated', time: '2 min ago', color: MoveTheme.primary),
        const _RecentChange(title: 'Plugin profile applied', time: '9 min ago', color: MoveTheme.success),
        const _RecentChange(title: 'Gaming beast mode saved', time: '16 min ago', color: MoveTheme.danger),
      ],
    );
  }
}

class _ModuleCard extends StatelessWidget {
  const _ModuleCard({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color),
          ),
          const Spacer(),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
          const SizedBox(height: 6),
          Text(subtitle, style: const TextStyle(color: Color(0xFFA9AEC8), fontSize: 12)),
        ],
      ),
    );
  }
}

class _RecentChange extends StatelessWidget {
  const _RecentChange({required this.title, required this.time, required this.color});

  final String title;
  final String time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111322),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(Icons.adjust_rounded, color: color),
          const SizedBox(width: 12),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w700))),
          Text(time, style: const TextStyle(color: Color(0xFF9BA1BE), fontSize: 12)),
        ],
      ),
    );
  }
}
