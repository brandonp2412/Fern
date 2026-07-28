import 'package:flutter/material.dart';
import '../state/app_state.dart';
import 'overview_screen.dart';
import 'settings_screen.dart';
import 'stats_screen.dart';
import 'activity_screen.dart';

class HomeShell extends StatefulWidget {
  final AppState state;

  const HomeShell({super.key, required this.state});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> with WidgetsBindingObserver {
  int _tab = 0;
  late final PageController _pageController = PageController(initialPage: _tab);

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final state = widget.state;
    _screens = [
      OverviewScreen(key: const ValueKey('overview'), state: state),
      ActivityScreen(key: const ValueKey('activity'), state: state),
      StatsScreen(key: const ValueKey('stats'), state: state),
      SettingsScreen(key: const ValueKey('settings'), state: state),
    ];
    state.load();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState s) {
    if (s == AppLifecycleState.resumed) {
      widget.state.load();
    }
  }

  void _selectTab(int i) {
    setState(() => _tab = i);
    if (widget.state.settings.swipeTabs && _pageController.hasClients) {
      _pageController.jumpToPage(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [for (final s in _screens) RepaintBoundary(child: s)];
    return Scaffold(
      body: widget.state.settings.swipeTabs
          ? PageView(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _tab = i),
              children: pages,
            )
          : IndexedStack(index: _tab, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: _selectTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Overview',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Activity',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
