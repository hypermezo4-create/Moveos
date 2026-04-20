import 'package:flutter/material.dart';

import 'core/theme/move_theme.dart';
import 'features/home/home_shell.dart';

class MoveOsApp extends StatelessWidget {
  const MoveOsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MoveOS Control',
      theme: MoveTheme.darkTheme,
      home: const HomeShell(),
    );
  }
}
