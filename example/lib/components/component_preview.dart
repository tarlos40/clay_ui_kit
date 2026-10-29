import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

class ComponentPreview extends StatefulWidget {
  final ClayThemeData theme;

  const ComponentPreview({super.key, required this.theme});

  @override
  State<ComponentPreview> createState() => _ComponentPreviewState();
}

class _ComponentPreviewState extends State<ComponentPreview> {
  bool _previewActive = true;

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    return ClayCard(
      children: [
        ClayCard.header(
          leading: HugeIcon(
            icon: HugeIcons.strokeRoundedTouchpad04,
            color: theme.primary,
            size: 26,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClayText.title('Interactive preview'),
              ClayText.label('TRY THE BUTTONS'),
            ],
          ),
        ),
        ClayCard.body(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _previewActive
                            ? Icons.check_circle_rounded
                            : Icons.touch_app_rounded,
                        color: _previewActive ? theme.success : theme.primary,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ClayText.body(
                          _previewActive
                              ? 'Preview activated successfully'
                              : 'Tap a button to see it in action',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ClayText.label('BUTTON VARIANTS'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ClayButton.primary(
                        _previewActive ? 'No Function' : 'Continue',
                        onPressed: _previewActive
                            ? () {}
                            : () => Navigator.pushNamed(
                                context,
                                '/component/button',
                              ),
                      ),
                      ClayButton.base(
                        _previewActive ? 'Reset' : 'Preview',
                        onPressed: () {
                          setState(() => _previewActive = !_previewActive);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  size: 10,
                  color: _previewActive ? theme.success : theme.secondary,
                ),
                const SizedBox(width: 8),
                ClayText.label(
                  _previewActive
                      ? 'Tap Reset to restore the demo'
                      : 'Continue opens the button documentation',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
