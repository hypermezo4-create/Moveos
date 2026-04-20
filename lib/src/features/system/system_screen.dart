import 'package:flutter/material.dart';

import '../../core/theme/move_theme.dart';
import '../../core/widgets/app_scaffold_shell.dart';
import '../../core/widgets/glow_card.dart';
import '../../core/widgets/section_title.dart';

class SystemScreen extends StatelessWidget {
  const SystemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldShell(
      title: 'System',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 120),
        children: [
          GlowCard(
            color: MoveTheme.primary,
            child: Row(
              children: const [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Framework Control', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20)),
                      SizedBox(height: 8),
                      Text('Your bridge for XML keys, intent actions, privileged writes, and SystemUI refresh.', style: TextStyle(color: Color(0xFFAAB0CA))),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Icon(Icons.memory_rounded, color: MoveTheme.primary, size: 42),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionTitle('System Core'),
          const SizedBox(height: 12),
          const _SystemGrid(),
          const SizedBox(height: 24),
          const SectionTitle('Settings Migration'),
          const SizedBox(height: 12),
          const _MappingTile(title: 'XML Keys Mapping', subtitle: 'Map old settings keys to the new control app UI', color: MoveTheme.primary),
          const _MappingTile(title: 'Preference Bridge', subtitle: 'Route toggles and lists to your real framework back-end', color: MoveTheme.secondary),
          const _MappingTile(title: 'Intent Actions', subtitle: 'Send refresh actions like my.intent.action.REFRESH_STATUSBAR', color: MoveTheme.success),
          const _MappingTile(title: 'Default Values', subtitle: 'Preserve original defaults from XML and overlay behavior', color: MoveTheme.warning),
        ],
      ),
    );
  }
}

class _SystemGrid extends StatelessWidget {
  const _SystemGrid();

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('Build Props', Icons.description_outlined, MoveTheme.secondary),
      ('Animations', Icons.motion_photos_on_outlined, MoveTheme.primary),
      ('CPU & Memory', Icons.speed_outlined, MoveTheme.success),
      ('Developer', Icons.code_outlined, MoveTheme.warning),
      ('Broadcasts', Icons.campaign_outlined, MoveTheme.danger),
      ('Recovery & Reboot', Icons.restart_alt_rounded, MoveTheme.secondary),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.25,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return GlowCard(
          color: item.$3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(item.$2, color: item.$3),
              const Spacer(),
              Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
        );
      },
    );
  }
}

class _MappingTile extends StatelessWidget {
  const _MappingTile({required this.title, required this.subtitle, required this.color});

  final String title;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111322),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Row(
        children: [
          Icon(Icons.arrow_circle_right_outlined, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Color(0xFFA8AEC9), fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
