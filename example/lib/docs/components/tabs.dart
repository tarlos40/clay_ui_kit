import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc tabsDocumentation = ComponentDoc(
  title: 'Tabs',
  subtitle: 'Components',
  description: 'A tab selector with pills, underline, or segmented styling. Use it standalone to switch its own child content, or place it in ClayScaffold to coordinate tabs with an external body and swipe gestures.',
  legends: [
    DocumentationLegend(label: 'Pills', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Underline', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Segmented', color: ClayColors.violet.s500),
    DocumentationLegend(label: 'Disabled Tab', color: ClayColors.slate.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Let Tabs Manage Their Content',
      description: 'By default showContent is true: ClayTabs displays the selected ClayTabItem.child and animates between children. Omit index to let the widget own selection, or pass index and update it from onChanged for controlled state.',
      code: '''
ClayTabs(
  style: ClayTabsStyle.segmented,
  initialIndex: 0,
  tabs: const [
    ClayTabItem(
      label: 'Overview',
      icon: Icon(Icons.dashboard_outlined),
      selectedIcon: Icon(Icons.dashboard_rounded),
      child: OverviewPage(),
    ),
    ClayTabItem(
      label: 'Activity',
      icon: Icon(Icons.history_rounded),
      badge: ClayBadge(label: 'New'),
      child: ActivityPage(),
    ),
    ClayTabItem(
      label: 'Settings',
      icon: Icon(Icons.settings_outlined),
      child: SettingsPage(),
      enabled: false,
    ),
  ],
  onChanged: (index) => debugPrint('Selected tab: ' + index.toString()),
)
''',
      preview: _TabsContentPreview(),
    ),
    ClayShowcase(
      title: 'Use Tabs with ClayScaffold and IndexedStack',
      description: 'Set showContent: false when the selected page is supplied by the Scaffold body. Keep one selected index for ClayTabs.index and IndexedStack.index, and update it in onChanged. This keeps all page children mounted, preserving local state such as scroll position.',
      code: '''
class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static const _pages = <Widget>[
    HomePage(),
    ActivityPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return ClayScaffold(
      clayTabs: ClayTabs(
        index: _selectedIndex,
        showContent: false,
        style: ClayTabsStyle.pills,
        tabs: const [
          ClayTabItem(
            label: 'Home',
            icon: Icon(Icons.home_rounded),
            child: SizedBox.shrink(),
          ),
          ClayTabItem(
            label: 'Activity',
            icon: Icon(Icons.history_rounded),
            child: SizedBox.shrink(),
          ),
          ClayTabItem(
            label: 'Profile',
            icon: Icon(Icons.person_outline),
            child: SizedBox.shrink(),
          ),
        ],
        onChanged: (index) => setState(() => _selectedIndex = index),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
}
''',
      preview: SizedBox(height: 320, child: _TabsScaffoldPreview()),
    ),
    ClayShowcase(
      title: 'Navigate with Swipe Gestures',
      description: 'With showContent true, swipe horizontally over the displayed tab content. With showContent false inside ClayScaffold, swipe over the body instead. A drag of 40 logical pixels or a fling meeting swipeVelocityThreshold changes to the next enabled tab; swipes stop at the ends and skip disabled tabs. Disable swipeable when the content has its own horizontal gesture.',
      code: '''
ClayScaffold(
  clayTabs: ClayTabs(
    index: selectedIndex,
    showContent: false,
    swipeable: true,
    swipeVelocityThreshold: 500,
    tabs: tabs,
    onChanged: (index) => setState(() => selectedIndex = index),
  ),
  body: IndexedStack(index: selectedIndex, children: pages),
  hideTabsOnScroll: true,
)
''',
      preview: ClayTabs(
        style: ClayTabsStyle.underline,
        tabs: const [
          ClayTabItem(
            label: 'First',
            child: Center(child: Text('Swipe over this content')),
          ),
          ClayTabItem(
            label: 'Second',
            child: Center(child: Text('Second tab content')),
          ),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Choose a Layout and Style',
      description: 'Use isScrollable for a horizontally scrollable tab row, or expand to distribute tabs across the available width. Underline, pills, and segmented styles offer distinct selected states; badges and selectedIcon can enrich destinations.',
      code: '''
ClayTabs(
  style: ClayTabsStyle.underline,
  isScrollable: false,
  expand: true,
  tabPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  spacing: 4,
  borderRadius: 16,
  animationDuration: Duration(milliseconds: 300),
  indicatorColor: ClayColors.forest.s600,
  selectedForegroundColor: Colors.white,
  foregroundColor: ClayColors.slate.s700,
  backgroundColor: ClayColors.cloud.s50,
  tabs: tabs,
)
''',
      preview: ClayTabs(
        style: ClayTabsStyle.underline,
        isScrollable: false,
        expand: true,
        tabPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        spacing: 4,
        borderRadius: 16,
        animationDuration: const Duration(milliseconds: 300),
        indicatorColor: ClayColors.forest.s600,
        selectedForegroundColor: Colors.white,
        foregroundColor: ClayColors.slate.s700,
        backgroundColor: ClayColors.cloud.s50,
        tabs: const [
          ClayTabItem(label: 'Details', child: SizedBox.shrink()),
          ClayTabItem(label: 'History', child: SizedBox.shrink()),
          ClayTabItem(label: 'Files', child: SizedBox.shrink()),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'tabs',
      type: 'List<ClayTabItem>',
      description: 'Tab definitions; at least one is required.',
      required: true,
    ),
    ClayProp(
      name: 'index / initialIndex',
      type: 'int?',
      description: 'index makes selection controlled by the parent; update it in response to onChanged. Without index, initialIndex sets the starting tab and ClayTabs manages selection internally. Both are clamped to available tabs.',
      defaultValue: 'null / 0',
    ),
    ClayProp(
      name: 'onChanged',
      type: 'ValueChanged<int>?',
      description: 'Called with the new index after a tap or swipe changes selection. It does not update a controlled index by itself.',
    ),
    ClayProp(
      name: 'style',
      type: 'ClayTabsStyle',
      description: 'Visual style: pills, underline, or segmented.',
      defaultValue: 'pills',
    ),
    ClayProp(
      name: 'showContent / swipeable',
      type: 'bool',
      description: 'showContent renders the selected tab child; set false when ClayScaffold should render an external body. swipeable enables horizontal swipe gestures over the active content or Scaffold body.',
      defaultValue: 'true / true',
    ),
    ClayProp(
      name: 'isScrollable / expand',
      type: 'bool',
      description: 'isScrollable allows the tab row to scroll horizontally when it overflows. expand distributes tabs across available width and takes precedence over isScrollable.',
      defaultValue: 'true / false',
    ),
    ClayProp(
      name: 'swipeVelocityThreshold',
      type: 'double',
      description: 'Minimum horizontal fling velocity for a swipe change; a horizontal drag of at least 40 logical pixels also changes tabs.',
      defaultValue: '350',
    ),
    ClayProp(
      name: 'contentPadding / tabPadding / spacing',
      type: 'EdgeInsetsGeometry / EdgeInsetsGeometry / double',
      description: 'Inset around displayed child content, inner tab item padding, and gap between tabs.',
      defaultValue: 'EdgeInsets.zero / EdgeInsets.symmetric(horizontal: 16, vertical: 11) / 6',
    ),
    ClayProp(
      name: 'borderRadius / animationDuration',
      type: 'double / Duration',
      description: 'Corner radius and transition duration for tab changes.',
      defaultValue: '40 / 260 milliseconds',
    ),
    ClayProp(
      name: 'indicatorColor / backgroundColor',
      type: 'Color?',
      description: 'Selected pill/indicator color and tab group surface; defaults to theme primary and container.',
      defaultValue: 'theme.primary / theme.container',
    ),
    ClayProp(
      name: 'selectedForegroundColor / foregroundColor',
      type: 'Color?',
      description: 'Selected icon/text color and unselected icon/text color.',
      defaultValue: 'theme.onPrimary / theme.onBackgroundVariant',
    ),
    ClayProp(
      name: 'ClayTabItem.label / child',
      type: 'String / Widget',
      description: 'Required tab label and content widget. child is shown by ClayTabs only when showContent is true.',
    ),
    ClayProp(
      name: 'ClayTabItem.icon / selectedIcon / badge',
      type: 'Widget?',
      description: 'Optional icon, selected-state icon (falls back to icon), and trailing badge widget.',
    ),
    ClayProp(
      name: 'ClayTabItem.enabled',
      type: 'bool',
      description:
          'Disabled tabs cannot be selected by tap or swipe; swipes skip them.',
      defaultValue: 'true',
    ),
    ClayProp(
      name: 'ClayScaffold.hideTabsOnScroll',
      type: 'bool',
      description: 'Scaffold option that animates its clayTabs out while scrolling down and back in while scrolling up.',
      defaultValue: 'false',
    ),
  ],
);

class _TabsContentPreview extends StatefulWidget {
  const _TabsContentPreview();

  @override
  State<_TabsContentPreview> createState() => _TabsContentPreviewState();
}

class _TabsContentPreviewState extends State<_TabsContentPreview> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return ClayTabs(
      style: ClayTabsStyle.segmented,
      index: _index,
      onChanged: (index) => setState(() => _index = index),
      tabs: const [
        ClayTabItem(
          label: 'Overview',
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard_rounded),
          child: Center(child: Text('Overview content')),
        ),
        ClayTabItem(
          label: 'Activity',
          icon: Icon(Icons.history_rounded),
          badge: Icon(Icons.circle, size: 7, color: Colors.red),
          child: Center(child: Text('Activity content')),
        ),
        ClayTabItem(
          label: 'Settings',
          icon: Icon(Icons.settings_outlined),
          child: Center(child: Text('Settings content')),
          enabled: false,
        ),
      ],
    );
  }
}

class _TabsScaffoldPreview extends StatefulWidget {
  const _TabsScaffoldPreview();

  @override
  State<_TabsScaffoldPreview> createState() => _TabsScaffoldPreviewState();
}

class _TabsScaffoldPreviewState extends State<_TabsScaffoldPreview> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return ClayScaffold(
      clayTabs: ClayTabs(
        index: _index,
        showContent: false,
        tabs: const [
          ClayTabItem(label: 'Home', child: SizedBox.shrink()),
          ClayTabItem(label: 'Activity', child: SizedBox.shrink()),
          ClayTabItem(label: 'Profile', child: SizedBox.shrink()),
        ],
        onChanged: (index) => setState(() => _index = index),
      ),
      body: IndexedStack(
        index: _index,
        children: const [
          Center(child: Text('Home page')),
          Center(child: Text('Activity page')),
          Center(child: Text('Profile page')),
        ],
      ),
    );
  }
}
