import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:hugeicons/hugeicons.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return ClayScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClayFeedback(
              status: ClayFeedbackStatus.empty,
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedFileNotFound,
                color: theme.onTertiary,
                size: 32,
              ),
              animate: true,
              title: "Oops... Something's wrong",
              message: "It looks like the page you're trying to access doesn't exist",
              actionLabel: 'Go Home',
              onAction: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
