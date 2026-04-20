import 'package:flutter/material.dart';

import '../../core/theme/move_theme.dart';
import '../../core/widgets/app_scaffold_shell.dart';
import '../../core/widgets/section_title.dart';
import '../../core/widgets/setting_slider_tile.dart';
import '../../core/widgets/setting_switch_tile.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  double iconSize = 35;
  double blurLevel = 65;
  bool appColorIcons = true;
  bool hideDnd = false;
  bool soundEnabled = true;
  bool overlayEnabled = true;

  @override
  Widget build(BuildContext context) {
    return AppScaffoldShell(
      title: 'Notifications',
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 120),
        children: [
          const SectionTitle('Notification Icons'),
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
          SettingSwitchTile(
            title: 'App Color Icons',
            subtitle: 'Color notification icons using the application accent',
            value: appColorIcons,
            onChanged: (value) => setState(() => appColorIcons = value),
            icon: Icons.apps_rounded,
            color: MoveTheme.primary,
          ),
          SettingSwitchTile(
            title: 'Hide DND Notification',
            subtitle: 'Hide the persistent DND button from the notification row',
            value: hideDnd,
            onChanged: (value) => setState(() => hideDnd = value),
            icon: Icons.notifications_off_outlined,
            color: MoveTheme.danger,
          ),
          const SizedBox(height: 18),
          const SectionTitle('Behavior'),
          const SizedBox(height: 12),
          SettingSwitchTile(
            title: 'Notification Sound',
            subtitle: 'Keep notification effects active inside your custom layer',
            value: soundEnabled,
            onChanged: (value) => setState(() => soundEnabled = value),
            icon: Icons.music_note_outlined,
            color: MoveTheme.warning,
          ),
          SettingSwitchTile(
            title: 'Notification Overlay',
            subtitle: 'Enable your custom overlay package or MoveOS overlay bridge',
            value: overlayEnabled,
            onChanged: (value) => setState(() => overlayEnabled = value),
            icon: Icons.layers_outlined,
            color: MoveTheme.secondary,
          ),
          SettingSliderTile(
            title: 'Background Blur',
            value: blurLevel,
            min: 0,
            max: 100,
            label: '${blurLevel.round()}%',
            onChanged: (value) => setState(() => blurLevel = value),
            color: MoveTheme.secondary,
          ),
        ],
      ),
    );
  }
}
