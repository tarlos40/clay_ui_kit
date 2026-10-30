import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc refreshIndicatorDocumentation = ComponentDoc(
  title: 'Refresh Indicator',
  subtitle: 'Foundations',
  description: 'ClayRefreshIndicator adds a themed pull-to-refresh interaction to a scrollable child. Pull down from the top of the content past the trigger distance to run an asynchronous callback.',
  showcases: [
    ClayShowcase(
      title: 'Wrap a Scrollable Widget',
      description: 'Place a vertical scrollable widget inside ClayRefreshIndicator and provide an async onRefresh callback. The child must be able to scroll or overscroll at its top; AlwaysScrollableScrollPhysics also allows pulling when the list is short or empty.',
      code: '''
ClayRefreshIndicator(
  onRefresh: _reloadItems,
  child: ListView.builder(
    physics: const AlwaysScrollableScrollPhysics(),
    itemCount: items.length,
    itemBuilder: (context, index) => ListTile(
      title: Text(items[index].title),
    ),
  ),
)

Future<void> _reloadItems() async {
  await repository.reload();
}
''',
      preview: const _RefreshIndicatorPreview(),
    ),
    ClayShowcase(
      title: 'Use with ClayScaffold',
      description: 'For a full page, ClayScaffold can add the same indicator for you. Set useRefreshIndicator to true and provide onRefresh; when useScrollView is enabled, the scaffold creates an always-scrollable vertical view for its body.',
      code: '''
ClayScaffold(
  body: const MyPageContent(),
  useScrollView: true,
  useRefreshIndicator: true,
  onRefresh: _reloadItems,
  triggerDistance: 80,
  indicatorSize: 48,
)
''',
      preview: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClayText.body('Use the integrated Scaffold options:'),
          const SizedBox(height: 10),
          ClayText.label('useRefreshIndicator: true'),
          ClayText.label('onRefresh: _reloadItems'),
          ClayText.label('useScrollView: true'),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'child',
      type: 'Widget',
      description: 'Scrollable content that emits scroll notifications, typically a ListView or SingleChildScrollView.',
      required: true,
    ),
    ClayProp(
      name: 'onRefresh',
      type: 'RefreshCallback',
      description: 'Async operation invoked when the pull reaches triggerDistance. The indicator resets when the future completes.',
      required: true,
    ),
    ClayProp(
      name: 'triggerDistance',
      type: 'double',
      description: 'Pull distance required to start the refresh callback.',
      defaultValue: '80',
    ),
    ClayProp(
      name: 'indicatorSize',
      type: 'double',
      description: 'Indicator height; its width is 1.65 times this value.',
      defaultValue: '48',
    ),
    ClayProp(
      name: 'color',
      type: 'Color?',
      description:
          'Wave and progress color. Defaults to the theme primary color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'backgroundColor',
      type: 'Color?',
      description:
          'Indicator surface color. Defaults to the theme container color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'enabled',
      type: 'bool',
      description: 'Whether pull gestures trigger and display the indicator.',
      defaultValue: 'true',
    ),
  ],
);

class _RefreshIndicatorPreview extends StatelessWidget {
  const _RefreshIndicatorPreview();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ClayRefreshIndicator(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 500));
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            for (var index = 1; index <= 4; index++)
              ListTile(
                leading: CircleAvatar(child: Text('$index')),
                title: Text('Refreshable item $index'),
                subtitle: const Text('Pull down from the top to refresh.'),
              ),
          ],
        ),
      ),
    );
  }
}
