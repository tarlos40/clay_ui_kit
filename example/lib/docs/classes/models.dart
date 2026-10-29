import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

class DocumentationLegend {
  final String label;
  final Color color;

  const DocumentationLegend({required this.label, required this.color});
}

class ComponentDoc {
  final String title;
  final String subtitle;
  final String description;
  final List<DocumentationLegend> legends;
  final List<Widget> showcases;
  final List<ClayProp> props;

  const ComponentDoc({
    required this.title,
    required this.subtitle,
    required this.description,
    this.legends = const [],
    this.showcases = const [],
    this.props = const [],
  });
}
