import 'package:flutter/material.dart';

import '../../core/theme/move_theme.dart';
import '../../core/widgets/status_badge.dart';
import '../gaming/gaming_screen.dart';
import '../home/pages/dashboard_screen.dart';
import '../launcher/launcher_screen.dart';
import '../plugins/plugins_screen.dart';
import '../security/security_screen.dart';
import '../system/system_screen.dart';
import '../visual/visual_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static final List<Widget> _pages = [
    const DashboardScreen(),
    const SystemScreen(),
    const VisualScreen(),
    const GamingScreen(),
    const SecurityScreen(),
  ];

  static const _labels = ['Home', 'System', 'Visual', 'Gaming', 'Security'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('MoveOS Control'),
            Text(
              _labels[_index],
              style: TextStyle(color: Colors.white.withOpacity(0.64), fontSize: 12),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: StatusBadge(label: 'VERIFIED', color: MoveTheme.success),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF0D0F18),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF181B2D), Color(0xFF0F1120)],
                  ),
                  border: Border.all(color: MoveTheme.primary.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        'assets/branding/moveos_logo.png',
                        height: 56,
                        width: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('MoveOS Control', style: TextStyle(fontWeight: FontWeight.w800)),
                          SizedBox(height: 4),
                          Text('Power • Control • Freedom', style: TextStyle(fontSize: 12, color: Color(0xFF9AA0BF))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                leading: const Icon(Icons.dashboard_outlined),
                title: const Text('Dashboard'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                leading: const Icon(Icons.extension_outlined),
                title: const Text('Plugins'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PluginsScreen()));
                },
              ),
              ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                leading: const Icon(Icons.rocket_launch_outlined),
                title: const Text('Launcher'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LauncherScreen()));
                },
              ),
              ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                leading: const Icon(Icons.security_outlined),
                title: const Text('Integrity Center'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _index = 4);
                },
              ),
            ],
          ),
        ),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B0D19), MoveTheme.background],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: IndexedStack(index: _index, children: _pages),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BottomNavigationBar(
            currentIndex: _index,
            onTap: (value) => setState(() => _index = value),
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xFF101320),
            selectedItemColor: MoveTheme.primary,
            unselectedItemColor: const Color(0xFF8C90AD),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_rounded), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.memory_outlined), activeIcon: Icon(Icons.memory_rounded), label: 'System'),
              BottomNavigationBarItem(icon: Icon(Icons.palette_outlined), activeIcon: Icon(Icons.palette_rounded), label: 'Visual'),
              BottomNavigationBarItem(icon: Icon(Icons.sports_esports_outlined), activeIcon: Icon(Icons.sports_esports_rounded), label: 'Gaming'),
              BottomNavigationBarItem(icon: Icon(Icons.verified_user_outlined), activeIcon: Icon(Icons.verified_user_rounded), label: 'Security'),
            ],
          ),
        ),
      ),
    );
  }
}
