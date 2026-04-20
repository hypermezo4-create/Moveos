import 'package:flutter/material.dart';

import '../../core/theme/move_theme.dart';
import '../../core/widgets/app_scaffold_shell.dart';
import '../../core/widgets/glow_card.dart';
import '../../core/widgets/section_title.dart';

class LauncherScreen extends StatelessWidget {
  const LauncherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('Home Screen', 'Grid, icons, dock', Icons.home_work_outlined, MoveTheme.primary),
      ('App Drawer', 'Layout, blur, categories', Icons.apps_rounded, MoveTheme.secondary),
      ('Gestures', 'Swipe, tap, shortcuts', Icons.gesture_rounded, MoveTheme.warning),
      ('Effects', 'Animation, parallax', Icons.auto_awesome_outlined, MoveTheme.danger),
      ('Widgets', 'MoveOS widgets', Icons.widgets_outlined, MoveTheme.success),
      ('Backup', 'Layout & data', Icons.backup_outlined, MoveTheme.primary),
    ];

    return AppScaffoldShell(
      title: 'Launcher',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 120),
        children: [
          GlowCard(
            color: MoveTheme.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Launcher Control', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22)),
                SizedBox(height: 8),
                Text('Prepare the launcher page for grid styles, dock controls, gestures, and widgets.', style: TextStyle(color: Color(0xFFAAB0CA))),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionTitle('Launcher Modules'),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.18,
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
                    Text(item.$2, style: const TextStyle(fontSize: 12, color: Color(0xFFAAB0CA))),
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
