import 'package:flutter/material.dart';

import '../../core/theme/move_theme.dart';
import '../../core/widgets/app_scaffold_shell.dart';
import '../../core/widgets/glow_card.dart';
import '../../core/widgets/section_title.dart';
import '../../core/widgets/setting_slider_tile.dart';
import '../../core/widgets/setting_switch_tile.dart';

class StatusbarScreen extends StatefulWidget {
  const StatusbarScreen({super.key});

  @override
  State<StatusbarScreen> createState() => _StatusbarScreenState();
}

class _StatusbarScreenState extends State<StatusbarScreen> {
  double iconSize = 35;
  double iconSpacing = 12;
  bool colorNotificationIcons = true;
  bool hidePersistentDnd = false;
  bool expandTopNotification = true;
  bool notificationSound = true;

  @override
  Widget build(BuildContext context) {
    return AppScaffoldShell(
      title: 'Status Bar',
      actions: [
        TextButton(
          onPressed: () {},
          child: const Text('Apply & Refresh'),
        ),
      ],
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 120),
        children: [
          GlowCard(
            color: MoveTheme.secondary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Statusbar Adjustment', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                const Text('This is the first visual shell for your migrated status bar controls.', style: TextStyle(color: Color(0xFFA7ADC8))),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0E1B),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: MoveTheme.secondary.withOpacity(0.35)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('09:15', style: TextStyle(color: MoveTheme.success, fontWeight: FontWeight.w800, fontSize: 18)),
                      Row(
                        children: [
                          Icon(Icons.signal_cellular_alt_rounded, color: MoveTheme.secondary),
                          SizedBox(width: 6),
                          Icon(Icons.wifi_rounded, color: MoveTheme.secondary),
                          SizedBox(width: 6),
                          Icon(Icons.battery_full_rounded, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const SectionTitle('Notification Area'),
          const SizedBox(height: 12),
          SettingSliderTile(
            title: 'Icon Size',
            value: iconSize,
            min: 20,
            max: 50,
            label: iconSize.round().toString(),
            onChanged: (value) => setState(() => iconSize = value),
            color: MoveTheme.primary,
          ),
          SettingSliderTile(
            title: 'Icon Spacing',
            value: iconSpacing,
            min: 0,
            max: 24,
            label: iconSpacing.round().toString(),
            onChanged: (value) => setState(() => iconSpacing = value),
            color: MoveTheme.secondary,
          ),
          SettingSwitchTile(
            title: 'Color Notification Icons',
            subtitle: 'Use app color for notification icons in the status bar',
            value: colorNotificationIcons,
            onChanged: (value) => setState(() => colorNotificationIcons = value),
            icon: Icons.palette_outlined,
            color: MoveTheme.primary,
          ),
          SettingSwitchTile(
            title: 'Hide Persistent DND',
            subtitle: 'Hide the persistent DND button from the status bar',
            value: hidePersistentDnd,
            onChanged: (value) => setState(() => hidePersistentDnd = value),
            icon: Icons.do_not_disturb_alt_outlined,
            color: MoveTheme.danger,
          ),
          const SizedBox(height: 12),
          const SectionTitle('Behavior'),
          const SizedBox(height: 12),
          SettingSwitchTile(
            title: 'Expand Top Notification',
            subtitle: 'Expand notifications when pulled from the top region',
            value: expandTopNotification,
            onChanged: (value) => setState(() => expandTopNotification = value),
            icon: Icons.unfold_more_double_outlined,
            color: MoveTheme.secondary,
          ),
          SettingSwitchTile(
            title: 'Notification Sound',
            subtitle: 'Allow the MoveOS notification sound behavior layer',
            value: notificationSound,
            onChanged: (value) => setState(() => notificationSound = value),
            icon: Icons.volume_up_outlined,
            color: MoveTheme.warning,
          ),
        ],
      ),
    );
  }
}
