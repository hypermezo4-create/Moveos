import 'package:flutter/material.dart';

import '../../core/theme/move_theme.dart';
import '../../core/widgets/app_scaffold_shell.dart';
import '../../core/widgets/glow_card.dart';
import '../../core/widgets/section_title.dart';

class GamingScreen extends StatelessWidget {
  const GamingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('Game Booster', 'Maximum performance mode', Icons.flash_on_rounded, MoveTheme.danger),
      ('CPU Boost', 'Performance policy', Icons.memory_rounded, MoveTheme.warning),
      ('GPU Turbo', 'Graphics optimization', Icons.auto_awesome_motion_rounded, MoveTheme.primary),
      ('Touch Boost', 'Ultra responsive', Icons.touch_app_rounded, MoveTheme.success),
      ('Network Priority', 'Low latency mode', Icons.network_wifi_rounded, MoveTheme.secondary),
      ('Game Sidebar', 'Overlay shortcuts', Icons.view_sidebar_rounded, MoveTheme.primary),
    ];

    return AppScaffoldShell(
      title: 'Gaming',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 120),
        children: [
          GlowCard(
            color: MoveTheme.danger,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Gaming Beast Mode', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22)),
                SizedBox(height: 8),
                Text('A premium shell for per-game profiles, booster actions, touch response, and network priority.', style: TextStyle(color: Color(0xFFA9AEC8))),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionTitle('Gaming Tools'),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.16,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return GlowCard(
                color: item.$4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(item.$3, color: item.$4),
                    const Spacer(),
                    Text(item.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(item.$2, style: const TextStyle(fontSize: 12, color: Color(0xFFABB0CA))),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
