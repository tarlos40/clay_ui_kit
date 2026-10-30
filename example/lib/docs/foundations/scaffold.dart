import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc scaffoldDocumentation = ComponentDoc(
  title: 'Scaffold',
  subtitle: 'Foundations',
  description: 'ClayScaffold provides the page structure for a Clay app. It composes a background, optional navigation and app bars, tabs, a body, and a floating action button, with built-in scrolling and pull-to-refresh options.',
  showcases: [
    ClayShowcase(
      title: 'Create a Screen',
      description: 'Use body for the page content. Set useScrollView when the body is regular content that should scroll as one page; pass a scrollable widget directly when you need custom scrolling behavior.',
      code: '''
ClayScaffold(
  clayAppBar: const MyAppBar(),
  body: ListView(
    children: const [
      ClayText.title('Welcome'),
      ClayText.body('Your screen content goes here.'),
    ],
  ),
  useScrollView: false,
)
''',
      preview: SizedBox(
        height: 240,
        child: ClayScaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClayText.title('Screen body'),
                const SizedBox(height: 8),
                ClayText.body('Content is placed in the scaffold body.'),
              ],
            ),
          ),
        ),
      ),
    ),
    ClayShowcase(
      title: 'Add a Navigation Drawer',
      description: 'Assign ClayDrawer to clayDrawer and place ClayDrawer.menuButton in the app bar leading slot to open it.',
      code: '''
ClayScaffold(
  clayAppBar: Builder(
    builder: (context) => ClayAppBar(
      title: 'Workspace',
      leading: ClayDrawer.menuButton(context),
    ),
  ),
  clayDrawer: ClayDrawer(
    children: [
      ClayDrawer.title('Workspace'),
      ClayDrawer.subtitle('NAVIGATION'),
      ClayDrawer.action(
        icon: Icon(Icons.home_outlined),
        label: 'Home',
        onPressed: () {},
      ),
    ],
  ),
  body: const Center(child: Text('Page content')),
)
''',
      preview: SizedBox(
        height: 280,
        child: Builder(
          builder: (context) => ClayScaffold(
            clayAppBar: ClayAppBar(
              title: 'Workspace',
              leading: ClayDrawer.menuButton(context),
            ),
            clayDrawer: ClayDrawer(
              children: [
                ClayDrawer.title('Workspace'),
                ClayDrawer.subtitle('NAVIGATION'),
                ClayDrawer.action(
                  icon: const Icon(Icons.home_outlined),
                  label: 'Home',
                  onPressed: () {},
                ),
              ],
            ),
            body: const Center(child: Text('Tap the menu button')),
          ),
        ),
      ),
    ),
    ClayShowcase(
      title: 'Use Built-in Scrolling and Refresh',
      description: 'Set useScrollView to true to wrap body in a vertically scrolling view with horizontal padding. To enable pull-to-refresh, provide onRefresh and set useRefreshIndicator to true. The callback is required when refresh is enabled.',
      code: '''
ClayScaffold(
  body: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      ClayText.title('Latest updates'),
      ClayText.body('Pull down to reload this content.'),
    ],
  ),
  useScrollView: true,
  padding: 20,
  useRefreshIndicator: true,
  onRefresh: _reloadContent,
)
''',
      preview: const _ScaffoldRefreshPreview(),
    ),
  ],
  props: const [
    ClayProp(
      name: 'body',
      type: 'Widget?',
      description: 'Main content of the screen.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'clayAppBar',
      type: 'Widget?',
      description: 'Optional top app bar.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'clayDrawer',
      type: 'Widget?',
      description: 'Optional drawer widget, commonly a ClayDrawer. Open it from the app bar with ClayDrawer.menuButton(context).',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'clayTabs',
      type: 'Widget?',
      description: 'Optional tab header or tab content.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'clayNavigationBar',
      type: 'ClayNavigationBar?',
      description: 'Optional bottom navigation bar.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'clayFloatingActionButton',
      type: 'ClayFloatingActionButton?',
      description: 'Optional floating action button.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'backgroundColor',
      type: 'Color?',
      description:
          'Page background color. Cannot be set with backgroundGradient.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'backgroundGradient',
      type: 'Gradient?',
      description:
          'Page background gradient. Cannot be set with backgroundColor.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'useScrollView',
      type: 'bool',
      description: 'Wraps body in a vertical SingleChildScrollView with bouncing and always-scrollable physics.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'padding',
      type: 'double?',
      description: 'Horizontal padding applied by the built-in scroll view. Defaults to 12 when useScrollView is true.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'useRefreshIndicator',
      type: 'bool',
      description:
          'Wraps the body in ClayRefreshIndicator. Requires onRefresh.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'onRefresh',
      type: 'RefreshCallback?',
      description: 'Async callback run when a pull reaches the refresh trigger distance.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'triggerDistance',
      type: 'double',
      description: 'Pull distance required to start refreshing.',
      defaultValue: '80',
    ),
    ClayProp(
      name: 'indicatorSize',
      type: 'double',
      description: 'Height of the built-in refresh indicator.',
      defaultValue: '48',
    ),
    ClayProp(
      name: 'hideAppBarOnScroll',
      type: 'bool',
      description: 'Animates the app bar out while scrolling down and back in while scrolling up.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'hideNavigationBarOnScroll',
      type: 'bool',
      description: 'Animates the navigation bar out while scrolling down and back in while scrolling up.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'hideTabsOnScroll',
      type: 'bool',
      description: 'Animates the tab header out while scrolling down and back in while scrolling up.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'extendBody',
      type: 'bool',
      description: 'Extends the body behind the bottom navigation area.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'extendBodyBehindAppBar',
      type: 'bool',
      description: 'Extends the body behind the app bar.',
      defaultValue: 'false',
    ),
  ],
);

class _ScaffoldRefreshPreview extends StatelessWidget {
  const _ScaffoldRefreshPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: ClayScaffold(
        useScrollView: true,
        padding: 12,
        useRefreshIndicator: true,
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 350));
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClayText.title('Latest updates'),
            const SizedBox(height: 8),
            ClayText.body('Pull down at the top to refresh this content.'),
            const SizedBox(height: 18),
            ClayText.label('Updated moments ago'),
          ],
        ),
      ),
    );
  }
}
