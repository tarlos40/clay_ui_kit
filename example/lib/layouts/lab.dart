import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

class LabLayout extends StatefulWidget {
  const LabLayout({super.key});

  @override
  State<LabLayout> createState() => _LabLayoutState();
}

class _LabLayoutState extends State<LabLayout> {
  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          ClayText.display("Testando"),

          ClayText.title("Testando"),

          ClayText.body("Testando"),

          ClayText.label("Testando"),

          SizedBox(height: 8),

          ClayButton.base('Base', onPressed: () {}, isLoading: false),

          SizedBox(height: 8),

          ClayButton.primary('Primary', onPressed: () {}, isLoading: false),

          SizedBox(height: 8),

          ClayButton.secondary(
            'Secondary',
            onPressed: () {},
            isLoading: false,
            size: ClayButtonSize.small,
          ),

          SizedBox(height: 8),

          ClayButton.third(
            'Third',
            onPressed: () {},
            isLoading: false,
            size: ClayButtonSize.large,
          ),

          SizedBox(height: 8),

          ClayButton.text(
            'Text',
            onPressed: () {},
            isLoading: false,
            iconLeft: Icon(Icons.abc_sharp),
          ),

          SizedBox(height: 8),

          ClayButton.icon(
            Icon(Icons.abc_sharp),
            onPressed: () {},
            isLoading: false,
            size: ClayButtonSize.large,
          ),

          SizedBox(height: 8),

          ClayButton.gradient(
            "Testando",
            colors: [
              ClayColors.sky,
              ClayColors.sky.s600,
              ClayColors.sky.s700,
              ClayColors.sky.s900,
            ],
            begin: AlignmentGeometry.bottomCenter,
            end: AlignmentGeometry.center,
            foregroundColor: ClayColors.sky.s50,
            onPressed: () {},
            iconLeft: Icon(Icons.import_contacts),
            iconRight: Icon(Icons.import_contacts),
          ),

          SizedBox(height: 8),

          ClayInput(
            label: 'Username',
            hintText: 'Enter your username',
            prefixIcon: const Icon(Icons.person_rounded),
            onChanged: (value) {},
          ),

          SizedBox(height: 8),

          ClayInput(
            label: 'Password',
            hintText: 'Enter your password',
            password: true,
            prefixIcon: const Icon(Icons.lock_rounded),
          ),

          SizedBox(height: 8),

          ClayInput(
            label: 'Email',
            hintText: 'example@email.com',
            errorText: 'Enter a valid email address.',
            prefixIcon: const Icon(Icons.email_rounded),
          ),

          SizedBox(height: 8),

          ClayInput(
            label: 'Email',
            errorText: 'Invalid email.',
            errorColor: Colors.orange,
          ),

          SizedBox(height: 8),

          ClayInput.textArea(
            label: 'Description',
            hintText: 'Write something...',
            minLines: 4,
            maxLines: 8,
          ),

          SizedBox(height: 8),

          ClayInput.textArea(
            label: 'Bio',
            hintText: 'Tell us about yourself...',
            maxLength: 500,
            minLines: 5,
            maxLines: 8,
          ),
        ],
      ),
    );
  }
}
