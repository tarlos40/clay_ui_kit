import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc navigationBarDocumentation = ComponentDoc(
  title: 'Navigation Bar',
  subtitle: 'Components',
  description: 'A bottom navigation surface for a small set of top-level sections. Keep the selected index in state and use it to synchronize the bar with an IndexedStack or another page-switching strategy.',
  legends: [
    DocumentationLegend(
      label: 'Selected Destination',
      color: ClayColors.cobalt.s500,
    ),
    DocumentationLegend(label: 'Swipe Navigation', color: ClayColors.sky.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Keep Pages Alive with IndexedStack',
      description: 'Use one selected index for both ClayNavigationBar and IndexedStack. IndexedStack shows only the child at that index while keeping the other page widgets mounted, preserving local state such as scroll position and form values when switching tabs.',
      code: '''
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const _pages = <Widget>[
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ClayScaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      clayNavigationBar: ClayNavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          ClayNavigationBar.destination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          ClayNavigationBar.destination(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          ClayNavigationBar.destination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
''',
      preview: SizedBox(
        height: 300,
        child: _NavigationBarIndexedStackPreview(),
      ),
    ),
    ClayShowcase(
      title: 'Configure Destinations and Swipe',
      description: 'Each destination is created with the destination constructor and provides an icon and label. ClayScaffold can translate horizontal swipes into adjacent index changes when swipeable is true; set it false when the body has its own horizontal gestures.',
      code: '''
ClayNavigationBar(
  selectedIndex: selectedIndex,
  onDestinationSelected: onDestinationSelected,
  swipeable: false,
  backgroundColor: ClayColors.cloud.s50,
  indicatorColor: ClayColors.forest.s600,
  onIndicatorColor: Colors.white,
  onUnindicatorColor: ClayColors.slate.s700,
  destinations: const [
    ClayNavigationBar.destination(
      icon: Icon(Icons.dashboard_outlined),
      label: 'Overview',
    ),
    ClayNavigationBar.destination(
      icon: Icon(Icons.notifications_none),
      label: 'Activity',
    ),
  ],
)
''',
      preview: SizedBox(
        height: 100,
        child: ClayNavigationBar(
          selectedIndex: 1,
          onDestinationSelected: (_) {},
          swipeable: false,
          backgroundColor: ClayColors.cloud.s50,
          indicatorColor: ClayColors.forest.s600,
          onIndicatorColor: Colors.white,
          onUnindicatorColor: ClayColors.slate.s700,
          destinations: const [
            ClayNavigationBar.destination(
              icon: Icon(Icons.dashboard_outlined),
              label: 'Overview',
            ),
            ClayNavigationBar.destination(
              icon: Icon(Icons.notifications_none),
              label: 'Activity',
            ),
          ],
        ),
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'selectedIndex',
      type: 'int',
      description: 'Index of the currently selected destination.',
      required: true,
    ),
    ClayProp(
      name: 'onDestinationSelected',
      type: 'ValueChanged<int>',
      description: 'Called when a destination is selected.',
      required: true,
    ),
    ClayProp(
      name: 'destinations',
      type: 'List<ClayNavigationBar>',
      description: 'Ordered destinations created with ClayNavigationBar.destination. Keep this order aligned with the pages in your body or IndexedStack.',
      required: true,
    ),
    ClayProp(
      name: 'swipeable',
      type: 'bool',
      description: 'When hosted by ClayScaffold, allow horizontal swipes on the body to select the adjacent destination. Disable if the body uses horizontal gestures or a PageView.',
      defaultValue: 'true',
    ),
    ClayProp(
      name: 'swipeVelocityThreshold',
      type: 'double',
      description: 'Minimum horizontal fling velocity for swipe navigation; a drag of at least 40 logical pixels also triggers a change.',
      defaultValue: '350',
    ),
    ClayProp(
      name: 'backgroundColor / indicatorColor',
      type: 'Color?',
      description: 'Optional bar surface and selected destination pill colors. Defaults use theme container and primary.',
      defaultValue: 'theme.container / theme.primary',
    ),
    ClayProp(
      name: 'onIndicatorColor / onUnindicatorColor',
      type: 'Color?',
      description: 'Icon and selected label color, and unselected icon and label color. Defaults use theme onPrimary/theme primary for selection and onContainer for unselected destinations.',
      defaultValue: 'theme.onPrimary / theme.onContainer',
    ),
    ClayProp(
      name: 'ClayNavigationBar.destination icon / label',
      type: 'Widget? / String?',
      description: 'Build each destination with its optional icon and text label. The destination constructor is for items inside destinations, not for rendering the entire bar.',
    ),
    ClayProp(
      name: 'IndexedStack integration',
      type: 'Flutter widget pattern',
      description: 'Use the same selectedIndex for IndexedStack.index and the navigation bar. All children remain mounted, preserving their state; this uses more memory than building only the active page.',
    ),
  ],
);

class _NavigationBarIndexedStackPreview extends StatefulWidget {
  const _NavigationBarIndexedStackPreview();

  @override
  State<_NavigationBarIndexedStackPreview> createState() =>
      _NavigationBarIndexedStackPreviewState();
}

class _NavigationBarIndexedStackPreviewState
    extends State<_NavigationBarIndexedStackPreview> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ClayScaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          Center(child: ClayText.title('Home page')),
          Center(child: ClayText.title('Search page')),
          Center(child: ClayText.title('Profile page')),
        ],
      ),
      clayNavigationBar: ClayNavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: const [
          ClayNavigationBar.destination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          ClayNavigationBar.destination(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          ClayNavigationBar.destination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
