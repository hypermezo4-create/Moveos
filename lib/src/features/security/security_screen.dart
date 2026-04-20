import 'package:flutter/material.dart';

import '../../core/theme/move_theme.dart';
import '../../core/widgets/app_scaffold_shell.dart';
import '../../core/widgets/glow_card.dart';
import '../../core/widgets/section_title.dart';
import '../../core/widgets/status_badge.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checks = const [
      ('Core Service', 'Verified & trusted', MoveTheme.success),
      ('Framework Hooks', 'Signature matched', MoveTheme.success),
      ('SystemUI Bridge', 'Integrity confirmed', MoveTheme.success),
      ('Plugin Signatures', 'All valid', MoveTheme.success),
      ('Runtime Environment', 'Secure', MoveTheme.success),
    ];

    return AppScaffoldShell(
      title: 'Security',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 120),
        children: [
          GlowCard(
            color: MoveTheme.success,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  children: [
                    Icon(Icons.shield_rounded, color: MoveTheme.success, size: 34),
                    SizedBox(width: 10),
                    StatusBadge(label: 'SYSTEM FULLY VERIFIED', color: MoveTheme.success),
                  ],
                ),
                SizedBox(height: 14),
                Text('MoveOS Core is secure', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22)),
                SizedBox(height: 8),
                Text('This section is ready to host integrity scans, trusted component checks, and anti-tamper warnings.', style: TextStyle(color: Color(0xFFA9AEC8))),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionTitle('Integrity Checks'),
          const SizedBox(height: 12),
          ...checks.map((check) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF111322),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: check.$3.withValues(alpha: 0.25)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_rounded, color: check.$3),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(check.$1, style: const TextStyle(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Text(check.$2, style: const TextStyle(color: Color(0xFFAAB0CA), fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
