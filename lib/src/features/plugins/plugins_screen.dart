import 'package:flutter/material.dart';

import '../../core/theme/move_theme.dart';
import '../../core/widgets/app_scaffold_shell.dart';
import '../../core/widgets/glow_card.dart';
import '../../core/widgets/section_title.dart';
import '../../core/widgets/status_badge.dart';

class PluginsScreen extends StatelessWidget {
  const PluginsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plugins = const [
      ('Statusbar Pro', 'v2.1.0', 'Verified', MoveTheme.success),
      ('QS Glass Style', 'v1.5.3', 'Verified', MoveTheme.success),
      ('Gaming Engine', 'v3.0.0', 'Internal', MoveTheme.primary),
      ('Launcher Ultra', 'v2.2.1', 'Verified', MoveTheme.success),
      ('Lockscreen Plus', 'v1.8.0', 'Experimental', MoveTheme.warning),
    ];

    return AppScaffoldShell(
      title: 'Plugins',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 120),
        children: [
          GlowCard(
            color: MoveTheme.primary,
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Plugin Manager', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22)),
                      SizedBox(height: 8),
                      Text('Manage internal, verified, and experimental MoveOS modules.', style: TextStyle(color: Color(0xFFAAB0CA))),
                    ],
                  ),
                ),
                Icon(Icons.extension_rounded, color: MoveTheme.primary, size: 42),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionTitle('Installed Plugins'),
          const SizedBox(height: 12),
          ...plugins.map((plugin) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF111322),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: plugin.$4.withOpacity(0.25)),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 46,
                      width: 46,
                      decoration: BoxDecoration(
                        color: plugin.$4.withOpacity(0.14),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(Icons.widgets_outlined, color: plugin.$4),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(plugin.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text(plugin.$2, style: const TextStyle(color: Color(0xFFAAB0CA), fontSize: 12)),
                        ],
                      ),
                    ),
                    StatusBadge(label: plugin.$3.toUpperCase(), color: plugin.$4),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
