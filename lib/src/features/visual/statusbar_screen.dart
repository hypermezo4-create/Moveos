import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/theme/move_theme.dart';
import '../../core/widgets/status_badge.dart';
import 'notifications_screen.dart';

class StatusbarScreen extends StatefulWidget {
  const StatusbarScreen({super.key});

  @override
  State<StatusbarScreen> createState() => _StatusbarScreenState();
}

class _StatusbarScreenState extends State<StatusbarScreen> {
  static const String _prefsKey = 'status_bar_elem_position';
  static const String _defaultLayoutString =
      'elem_status.33;elem_clock.21;elem_bat.31;elem_net1.1;elem_net2.11;elem_wifi.2;elem_notif.22;elem_speed.3;elem_weather.32;elem_date.12;';

  static const List<_EditorElement> _elements = [
    _EditorElement(id: 'elem_status', label: 'Status icons', asset: 'assets/statusbar/elem_status.png'),
    _EditorElement(id: 'elem_clock', label: 'Clock', asset: 'assets/statusbar/elem_clock.png'),
    _EditorElement(id: 'elem_bat', label: 'Battery', asset: 'assets/statusbar/elem_bat.png'),
    _EditorElement(id: 'elem_net1', label: 'Mobile data 1', asset: 'assets/statusbar/elem_net1.png'),
    _EditorElement(id: 'elem_net2', label: 'Mobile data 2', asset: 'assets/statusbar/elem_net2.png'),
    _EditorElement(id: 'elem_wifi', label: 'Wi‑Fi', asset: 'assets/statusbar/elem_wifi.png'),
    _EditorElement(id: 'elem_notif', label: 'Notification icons', asset: 'assets/statusbar/elem_notif.png'),
    _EditorElement(id: 'elem_speed', label: 'Net speed', asset: 'assets/statusbar/elem_speed.png'),
    _EditorElement(id: 'elem_weather', label: 'Weather', asset: 'assets/statusbar/elem_weather.png'),
    _EditorElement(id: 'elem_date', label: 'Date', asset: 'assets/statusbar/elem_date.png'),
  ];

  static const Map<int, Offset> _slotAnchors = {
    21: Offset(0.09, 0.18),
    22: Offset(0.09, 0.40),
    33: Offset(0.09, 0.70),
    32: Offset(0.18, 0.70),
    31: Offset(0.09, 0.83),
    1: Offset(0.75, 0.18),
    11: Offset(0.84, 0.18),
    12: Offset(0.93, 0.18),
    2: Offset(0.82, 0.70),
    3: Offset(0.93, 0.70),
  };

  static const List<_SectionCardData> _sectionCards = [
    _SectionCardData(
      title: 'Statusbar',
      subtitle: 'Layout editor • size bridge',
      leadingAsset: 'assets/statusbar/elem_statusbar_card.png',
      secondaryAsset: 'assets/statusbar/elem_resize_card.png',
    ),
    _SectionCardData(
      title: 'Battery',
      subtitle: 'Battery view • charging icon',
      leadingAsset: 'assets/statusbar/elem_bat_card.png',
      trailingIcon: Icons.bolt_rounded,
    ),
    _SectionCardData(
      title: 'Clock',
      subtitle: 'Clock color • size • style',
      leadingAsset: 'assets/statusbar/elem_clock_card.png',
      secondaryAsset: 'assets/statusbar/elem_clock.png',
    ),
    _SectionCardData(
      title: 'Netspeed',
      subtitle: 'Speed color • size • offset',
      leadingAsset: 'assets/statusbar/elem_speed_card.png',
      secondaryAsset: 'assets/statusbar/elem_weather_card.png',
    ),
    _SectionCardData(
      title: 'Network',
      subtitle: 'Network icons • dual SIM',
      leadingAsset: 'assets/statusbar/elem_net_card.png',
      secondaryAsset: 'assets/statusbar/elem_wifi.png',
    ),
    _SectionCardData(
      title: 'Notification icons',
      subtitle: 'Icon color • size • behavior',
      leadingAsset: 'assets/statusbar/elem_notif_card.png',
      secondaryAsset: 'assets/statusbar/elem_prompt_card.png',
    ),
    _SectionCardData(
      title: 'Status icons',
      subtitle: 'Bluetooth • alarm • offset',
      leadingAsset: 'assets/statusbar/elem_status_card.png',
      trailingIcon: Icons.alarm_rounded,
    ),
    _SectionCardData(
      title: 'Date',
      subtitle: 'Color • size • offset',
      leadingAsset: 'assets/statusbar/elem_date_card.png',
      secondaryAsset: 'assets/statusbar/elem_date.png',
    ),
  ];

  late Map<String, int> _layout;
  bool _loading = true;
  String? _draggingId;
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    _layout = _parseLayout(_defaultLayoutString);
    _restoreSavedLayout();
  }

  Future<void> _restoreSavedLayout() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefsKey);
    if (saved != null && saved.isNotEmpty) {
      _layout = _parseLayout(saved);
    }
    if (!mounted) return;
    setState(() => _loading = false);
  }

  Map<String, int> _parseLayout(String layoutString) {
    final parsed = <String, int>{};
    for (final item in _elements) {
      parsed[item.id] = 0;
    }
    for (final raw in layoutString.split(';')) {
      if (raw.trim().isEmpty) continue;
      final parts = raw.split('.');
      if (parts.length != 2) continue;
      final slot = int.tryParse(parts[1]);
      if (slot == null) continue;
      parsed[parts[0]] = slot;
    }
    final missingSlots = _slotAnchors.keys.where((slot) => !parsed.values.contains(slot)).toList();
    for (final entry in parsed.entries.where((entry) => entry.value == 0)) {
      if (missingSlots.isEmpty) break;
      parsed[entry.key] = missingSlots.removeAt(0);
    }
    return parsed;
  }

  String _encodedLayout() {
    return _elements
        .map((item) => '${item.id}.${_layout[item.id]};')
        .join();
  }

  Future<void> _persistLayout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, _encodedLayout());
    if (!mounted) return;
    setState(() => _saved = true);
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _saved = false);
    });
  }

  void _handleDrop(String draggedId, int targetSlot) {
    final sourceSlot = _layout[draggedId];
    if (sourceSlot == null || sourceSlot == targetSlot) return;

    String? occupantId;
    for (final entry in _layout.entries) {
      if (entry.value == targetSlot) {
        occupantId = entry.key;
        break;
      }
    }

    setState(() {
      _layout[draggedId] = targetSlot;
      if (occupantId != null) {
        _layout[occupantId] = sourceSlot;
      }
      _draggingId = null;
    });
    _persistLayout();
  }

  void _resetLayout() {
    setState(() {
      _layout = _parseLayout(_defaultLayoutString);
      _draggingId = null;
    });
    _persistLayout();
  }

  void _openSection(_SectionCardData card) {
    if (card.title == 'Notification icons') {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NotificationsScreen()));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: MoveTheme.panelRaised,
        content: Text('${card.title} wiring is the next step after this layout editor.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: MoveTheme.primary)),
      );
    }

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF090909), MoveTheme.background],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 120),
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                  ),
                  const Spacer(),
                  if (_saved) const StatusBadge(label: 'AUTO SAVED', color: MoveTheme.primary),
                ],
              ),
              const SizedBox(height: 6),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800),
                  children: const [
                    TextSpan(text: 'Statusbar ', style: TextStyle(color: Colors.white)),
                    TextSpan(text: 'adjustment', style: TextStyle(color: MoveTheme.primary)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Drag icons with your finger and the layout updates instantly. Saved as status_bar_elem_position.',
                      style: TextStyle(color: MoveTheme.textMuted, height: 1.4),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: _resetLayout,
                    icon: const Icon(Icons.restart_alt_rounded, size: 18),
                    label: const Text('Reset layout'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: MoveTheme.primary,
                      side: BorderSide(color: MoveTheme.primary.withValues(alpha: 0.50)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              _PreviewFrame(
                slotAnchors: _slotAnchors,
                elements: _elements,
                layout: _layout,
                draggingId: _draggingId,
                onDragStarted: (id) => setState(() => _draggingId = id),
                onDragEnded: () => setState(() => _draggingId = null),
                onAccept: _handleDrop,
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MoveTheme.panelAlt,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: MoveTheme.primary.withValues(alpha: 0.20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Current layout string',
                            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(text: _encodedLayout()));
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Layout string copied to clipboard.')),
                            );
                          },
                          icon: const Icon(Icons.content_copy_rounded, color: MoveTheme.primary),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _encodedLayout(),
                      style: const TextStyle(
                        color: MoveTheme.secondary,
                        fontSize: 13,
                        height: 1.5,
                        letterSpacing: 0.15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              GridView.builder(
                itemCount: _sectionCards.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.55,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                itemBuilder: (context, index) {
                  final card = _sectionCards[index];
                  return _SectionCard(
                    data: card,
                    onTap: () => _openSection(card),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreviewFrame extends StatelessWidget {
  const _PreviewFrame({
    required this.slotAnchors,
    required this.elements,
    required this.layout,
    required this.draggingId,
    required this.onDragStarted,
    required this.onDragEnded,
    required this.onAccept,
  });

  final Map<int, Offset> slotAnchors;
  final List<_EditorElement> elements;
  final Map<String, int> layout;
  final String? draggingId;
  final ValueChanged<String> onDragStarted;
  final VoidCallback onDragEnded;
  final void Function(String draggedId, int targetSlot) onAccept;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.48,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          const iconSize = 54.0;

          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF050505),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: MoveTheme.primary.withValues(alpha: 0.85), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: MoveTheme.primary.withValues(alpha: 0.12),
                  blurRadius: 28,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _GridPainter(),
                  ),
                ),
                Positioned(
                  left: width * 0.5 - 0.5,
                  top: 24,
                  bottom: 24,
                  child: Container(width: 1, color: MoveTheme.primary.withValues(alpha: 0.90)),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: height * 0.52,
                  child: Container(
                    height: 18,
                    color: const Color(0xFF2D2D2D),
                  ),
                ),
                for (final slot in slotAnchors.entries)
                  Positioned(
                    left: (width * slot.value.dx) - (iconSize / 2),
                    top: (height * slot.value.dy) - (iconSize / 2),
                    child: _SlotTarget(
                      slotId: slot.key,
                      size: iconSize,
                      isHovered: false,
                      child: _buildOccupant(slot.key),
                      onAccept: (draggedId) => onAccept(draggedId, slot.key),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOccupant(int slotId) {
    final item = elements.cast<_EditorElement?>().firstWhere(
          (element) => layout[element!.id] == slotId,
          orElse: () => null,
        );

    if (item == null) {
      return Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: MoveTheme.primary.withValues(alpha: 0.08)),
        ),
      );
    }

    final isDragging = draggingId == item.id;
    return LongPressDraggable<String>(
      data: item.id,
      onDragStarted: () => onDragStarted(item.id),
      onDragEnd: (_) => onDragEnded(),
      feedback: Transform.scale(
        scale: 1.15,
        child: Material(
          color: Colors.transparent,
          child: _PreviewIcon(asset: item.asset, elevated: true),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.18,
        child: _PreviewIcon(asset: item.asset),
      ),
      child: AnimatedScale(
        scale: isDragging ? 1.08 : 1,
        duration: const Duration(milliseconds: 150),
        child: _PreviewIcon(asset: item.asset),
      ),
    );
  }
}

class _SlotTarget extends StatefulWidget {
  const _SlotTarget({
    required this.slotId,
    required this.size,
    required this.child,
    required this.onAccept,
    required this.isHovered,
  });

  final int slotId;
  final double size;
  final Widget child;
  final ValueChanged<String> onAccept;
  final bool isHovered;

  @override
  State<_SlotTarget> createState() => _SlotTargetState();
}

class _SlotTargetState extends State<_SlotTarget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onWillAcceptWithDetails: (_) {
        setState(() => _hovered = true);
        return true;
      },
      onLeave: (_) => setState(() => _hovered = false),
      onAcceptWithDetails: (details) {
        setState(() => _hovered = false);
        widget.onAccept(details.data);
      },
      builder: (context, candidateData, rejectedData) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: (_hovered || candidateData.isNotEmpty)
                  ? MoveTheme.highlight
                  : Colors.transparent,
              width: 1.1,
            ),
            color: (_hovered || candidateData.isNotEmpty)
                ? MoveTheme.primary.withValues(alpha: 0.08)
                : Colors.transparent,
          ),
          child: widget.child,
        );
      },
    );
  }
}

class _PreviewIcon extends StatelessWidget {
  const _PreviewIcon({required this.asset, this.elevated = false});

  final String asset;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: elevated ? MoveTheme.panelRaised : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        boxShadow: elevated
            ? [
                BoxShadow(
                  color: MoveTheme.primary.withValues(alpha: 0.18),
                  blurRadius: 18,
                ),
              ]
            : null,
      ),
      child: ColorFiltered(
        colorFilter: const ColorFilter.mode(MoveTheme.primary, BlendMode.srcIn),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Image.asset(asset, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.data, required this.onTap});

  final _SectionCardData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: MoveTheme.panel,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: MoveTheme.primary.withValues(alpha: 0.28)),
            boxShadow: [
              BoxShadow(
                color: MoveTheme.primary.withValues(alpha: 0.08),
                blurRadius: 18,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _CardBadge(asset: data.leadingAsset),
                  const SizedBox(width: 8),
                  if (data.secondaryAsset != null) _CardBadge(asset: data.secondaryAsset!),
                  if (data.trailingIcon != null) _IconBadge(icon: data.trailingIcon!),
                  const Spacer(),
                  const Icon(Icons.chevron_right_rounded, color: MoveTheme.primary),
                ],
              ),
              const Spacer(),
              Text(data.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
              const SizedBox(height: 4),
              Text(
                data.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: MoveTheme.textMuted, fontSize: 13, height: 1.35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardBadge extends StatelessWidget {
  const _CardBadge({required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: MoveTheme.panelRaised,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MoveTheme.primary.withValues(alpha: 0.16)),
      ),
      child: ColorFiltered(
        colorFilter: const ColorFilter.mode(MoveTheme.primary, BlendMode.srcIn),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset(asset, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: MoveTheme.panelRaised,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MoveTheme.primary.withValues(alpha: 0.16)),
      ),
      child: Icon(icon, size: 20, color: MoveTheme.primary),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = MoveTheme.primary.withValues(alpha: 0.08)
      ..strokeWidth = 1;
    const gap = 22.0;

    for (double x = -size.height; x < size.width + size.height; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), gridPaint);
    }
    for (double x = 0; x < size.width + size.height; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x - size.height, size.height), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _EditorElement {
  const _EditorElement({
    required this.id,
    required this.label,
    required this.asset,
  });

  final String id;
  final String label;
  final String asset;
}

class _SectionCardData {
  const _SectionCardData({
    required this.title,
    required this.subtitle,
    required this.leadingAsset,
    this.secondaryAsset,
    this.trailingIcon,
  });

  final String title;
  final String subtitle;
  final String leadingAsset;
  final String? secondaryAsset;
  final IconData? trailingIcon;
}
