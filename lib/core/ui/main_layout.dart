import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../features/dashboard/presentation/screen/dashboard_screen.dart';
import '../../features/production/presentation/screen/downtime_history_screen.dart';
import '../../features/production/presentation/screen/packer_screen.dart';
import '../../features/production/presentation/screen/production_screen.dart';
import '../../features/production/presentation/screen/station_screen.dart';
import '../../features/settings/presentation/screen/settings_screen.dart';
import 'glass_container.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ProductionScreen(),
    const StationScreen(),
    const PackerScreen(),
    const DashboardScreen(),
    const DowntimeHistoryScreen(),
    const SettingsScreen(), // 5
  ];

  Future<void> _handleEsc() async {
    // If a dialog is open (Navigator can pop), pop it.
    // If not, go to Dashboard (Index 3).
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      if (_selectedIndex != 3) {
        setState(() => _selectedIndex = 3);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 2. Global Shortcuts using FocusableActionDetector for robustness
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): _handleEsc,
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          body: Stack(
            children: [
              // Background Gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1E1E1E),
                      Color(0xFF2D2D2D), // Darker Grey Gradient
                    ],
                  ),
                ),
              ),

              // Content
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 800;

                  if (isWide) {
                    // Desktop / Tablet Layout
                    return Row(
                      children: [
                        // Sidebar
                        GlassContainer(
                          margin: const EdgeInsets.all(16),
                          borderRadius: BorderRadius.circular(16),
                          opacity: 0.1,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                      minHeight: constraints.maxHeight),
                                  child: IntrinsicHeight(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: NavigationRail(
                                            backgroundColor: Colors.transparent,
                                            selectedIndex: _selectedIndex,
                                            onDestinationSelected: (int index) {
                                              setState(() {
                                                _selectedIndex = index;
                                              });
                                            },
                                            labelType:
                                                NavigationRailLabelType.all,
                                            leading: const Padding(
                                              padding: EdgeInsets.all(
                                                  32.0), // Generous Padding
                                              child: DigitalClock(),
                                            ),
                                            destinations: const [
                                              NavigationRailDestination(
                                                icon: Icon(Icons
                                                    .precision_manufacturing_outlined),
                                                selectedIcon: Icon(Icons
                                                    .precision_manufacturing),
                                                label: Text('Produção'),
                                              ),
                                              NavigationRailDestination(
                                                icon: Icon(Icons
                                                    .settings_input_component_outlined),
                                                selectedIcon: Icon(Icons
                                                    .settings_input_component),
                                                label: Text('Estações'),
                                              ),
                                              NavigationRailDestination(
                                                icon:
                                                    Icon(Icons.people_outlined),
                                                selectedIcon:
                                                    Icon(Icons.people),
                                                label: Text('Equipe'),
                                              ),
                                              NavigationRailDestination(
                                                icon: Icon(
                                                    Icons.analytics_outlined),
                                                selectedIcon:
                                                    Icon(Icons.analytics),
                                                label: Text('Dashboard'),
                                              ),
                                              NavigationRailDestination(
                                                icon: Icon(
                                                    Icons.history_toggle_off),
                                                selectedIcon:
                                                    Icon(Icons.history),
                                                label: Text('Paradas'),
                                              ),
                                              NavigationRailDestination(
                                                icon: Icon(
                                                    Icons.settings_outlined),
                                                selectedIcon:
                                                    Icon(Icons.settings),
                                                label: Text('Configurações'),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // Main Content Area
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 16, right: 16, bottom: 16),
                            child: GlassContainer(
                              opacity: 0.05,
                              borderRadius: BorderRadius.circular(16),
                              child: _screens[_selectedIndex],
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Mobile / Narrow Layout
                    return Column(
                      children: [
                        // Clock for mobile
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: DigitalClock(isSmall: true),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: GlassContainer(
                              opacity: 0.05,
                              borderRadius: BorderRadius.circular(16),
                              child: _screens[_selectedIndex],
                            ),
                          ),
                        ),
                        GlassContainer(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          opacity: 0.1,
                          child: NavigationBar(
                            backgroundColor: Colors.transparent,
                            selectedIndex: _selectedIndex,
                            onDestinationSelected: (int index) {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            destinations: const [
                              NavigationDestination(
                                icon: Icon(
                                    Icons.precision_manufacturing_outlined),
                                selectedIcon:
                                    Icon(Icons.precision_manufacturing),
                                label: 'Produção',
                              ),
                              NavigationDestination(
                                icon: Icon(
                                    Icons.settings_input_component_outlined),
                                selectedIcon:
                                    Icon(Icons.settings_input_component),
                                label: 'Estações',
                              ),
                              NavigationDestination(
                                icon: Icon(Icons.people_outlined),
                                selectedIcon: Icon(Icons.people),
                                label: 'Equipe',
                              ),
                              NavigationDestination(
                                icon: Icon(Icons.analytics_outlined),
                                selectedIcon: Icon(Icons.analytics),
                                label: 'Dashboard',
                              ),
                              NavigationDestination(
                                icon: Icon(Icons.settings_outlined),
                                selectedIcon: Icon(Icons.settings),
                                label: 'Configs',
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DigitalClock extends StatefulWidget {
  final bool isSmall;
  const DigitalClock({super.key, this.isSmall = false});

  @override
  State<DigitalClock> createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  late Timer _timer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _now = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final timeFormat = DateFormat('HH:mm:ss');

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          timeFormat.format(_now),
          style: TextStyle(
            fontSize: widget.isSmall ? 20 : 32, // Larger
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            color: Colors.white,
            letterSpacing: 2.0, // Better readability
          ),
        ),
        if (!widget.isSmall) ...[
          const SizedBox(height: 8),
          Text(
            dateFormat.format(_now),
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ]
      ],
    );
  }
}
