import 'package:flutter/material.dart';
import '../state/app_state.dart';
import 'overview_screen.dart';
import 'settings_screen.dart';
import 'stats_screen.dart';
import 'transactions_screen.dart';

class HomeShell extends StatefulWidget {
  final AppState state;

  const HomeShell({super.key, required this.state});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _tab = 0;
  late final PageController _pageController = PageController(initialPage: _tab);

  @override
  void initState() {
    super.initState();
    widget.state.bootstrap();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectTab(int i) {
    setState(() => _tab = i);
    if (widget.state.settings.swipeTabs && _pageController.hasClients) {
      _pageController.animateToPage(
        i,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final screens = [
      OverviewScreen(state: state),
      TransactionsScreen(state: state),
      StatsScreen(state: state),
      SettingsScreen(state: state),
    ];
    return Scaffold(
      body: state.settings.swipeTabs
          ? PageView(
              controller: _pageController,
              onPageChanged: (i) => setState(() => _tab = i),
              children: screens,
            )
          : IndexedStack(index: _tab, children: screens),
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
