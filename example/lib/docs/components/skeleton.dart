import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc skeletonDocumentation = ComponentDoc(
  title: 'Skeleton',
  subtitle: 'Components',
  description: 'An animated placeholder that reserves the shape of content while data or media is loading.',
  legends: [
    DocumentationLegend(label: 'Rectangle', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Circle', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Text', color: ClayColors.violet.s500),
    DocumentationLegend(
      label: 'Animation Disabled',
      color: ClayColors.slate.s500,
    ),
  ],
  showcases: [
    ClayShowcase(
      title: 'Match the Placeholder to Content',
      description: 'Use rectangle, circle, or text constructors. Compose multiple placeholders to approximate the layout that will replace them.',
      code: '''
Row(
  children: [
    const ClaySkeleton.circle(size: 48),
    const SizedBox(width: 12),
    const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClaySkeleton.text(width: 160),
        SizedBox(height: 8),
        ClaySkeleton.text(width: 110),
      ],
    ),
  ],
)
''',
      preview: const Row(
        children: [
          ClaySkeleton.circle(size: 48),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClaySkeleton.text(width: 160),
              SizedBox(height: 8),
              ClaySkeleton.text(width: 110),
            ],
          ),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'width / height',
      type: 'double?',
      description: 'Placeholder dimensions.',
      defaultValue: 'null / 16',
    ),
    ClayProp(
      name: 'shape / borderRadius',
      type: 'ClaySkeletonShape / double',
      description: 'Rectangle, circle, or pill shape and corner radius.',
    ),
    ClayProp(
      name: 'baseColor / highlightColor',
      type: 'Color?',
      description: 'Customize shimmer base and highlight colors.',
    ),
    ClayProp(
      name: 'duration',
      type: 'Duration',
      description: 'Duration of the shimmer cycle.',
      defaultValue: '1400 ms',
    ),
    ClayProp(
      name: 'enabled',
      type: 'bool',
      description: 'Disable shimmer while keeping the placeholder visible.',
      defaultValue: 'true',
    ),
    ClayProp(
      name: 'child',
      type: 'Widget?',
      description: 'Optional content clipped inside the placeholder.',
    ),
  ],
);