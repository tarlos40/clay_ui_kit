import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc paginationDocumentation = ComponentDoc(
  title: 'Pagination',
  subtitle: 'Components',
  description: 'State-driven page controls for result lists and catalogs, with numbered pages, first/last and previous/next controls, page information, color customization, and a compact responsive layout.',
  legends: [
    DocumentationLegend(label: 'Current Page', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Previous / Next', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Compact Layout', color: ClayColors.slate.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Connect Page State',
      description: 'Keep currentPage in the parent and update it from onPageChanged. Page numbers are one-based; numbered controls center around the current page and shift near the first and last pages.',
      code: '''
ClayPagination(
  currentPage: currentPage,
  totalPages: 12,
  onPageChanged: (page) => setState(() => currentPage = page),
  visiblePages: 5,
  showPageInfo: true,
)
''',
      preview: ClayPagination(
        currentPage: 3,
        totalPages: 12,
        onPageChanged: (_) {},
        showPageInfo: true,
      ),
    ),
    ClayShowcase(
      title: 'Compact Layout and Boundaries',
      description: 'compact always shows previous, current/total, and next controls. The same compact layout is selected automatically below 360 logical pixels. First/last controls and showPageInfo are omitted in this layout.',
      code: '''
ClayPagination(
  currentPage: currentPage,
  totalPages: 42,
  compact: true,
  showPreviousNext: true,
  onPageChanged: onPageChanged,
)

// totalPages: 0 renders no pagination controls.
''',
      preview: Column(
        children: [
          ClayPagination(
            currentPage: 8,
            totalPages: 42,
            compact: true,
            onPageChanged: (_) {},
          ),
          const SizedBox(height: 16),
          ClayPagination(
            currentPage: 1,
            totalPages: 1,
            showPageInfo: true,
            onPageChanged: (_) {},
          ),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Customize Controls',
      description: 'Change button dimensions, spacing, corner radius, and selected, unselected, or disabled colors to fit the surrounding surface.',
      code: '''
ClayPagination(
  currentPage: currentPage,
  totalPages: totalPages,
  visiblePages: 7,
  buttonSize: 42,
  spacing: 8,
  borderRadius: 14,
  activeColor: ClayColors.forest.s600,
  activeForegroundColor: Colors.white,
  backgroundColor: ClayColors.cloud.s50,
  foregroundColor: ClayColors.slate.s800,
  disabledColor: ClayColors.slate.s400,
  onPageChanged: onPageChanged,
)
''',
      preview: ClayPagination(
        currentPage: 4,
        totalPages: 9,
        visiblePages: 7,
        buttonSize: 42,
        spacing: 8,
        borderRadius: 14,
        activeColor: ClayColors.forest.s600,
        activeForegroundColor: Colors.white,
        backgroundColor: ClayColors.cloud.s50,
        foregroundColor: ClayColors.slate.s800,
        disabledColor: ClayColors.slate.s400,
        onPageChanged: (_) {},
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'currentPage',
      type: 'int',
      description: 'Current one-based page number. Must be at least 1; values above totalPages are clamped for display.',
      required: true,
    ),
    ClayProp(
      name: 'totalPages',
      type: 'int',
      description: 'Number of available pages. Zero or less renders no controls; when zero, the displayed page is zero.',
      required: true,
    ),
    ClayProp(
      name: 'onPageChanged',
      type: 'ValueChanged<int>',
      description: 'Called with the requested one-based page when it differs from the current displayed page.',
      required: true,
    ),
    ClayProp(
      name: 'visiblePages',
      type: 'int',
      description: 'Maximum number of numbered page buttons, not including arrow controls. Must be at least 1 and is capped at totalPages.',
      defaultValue: '5',
    ),
    ClayProp(
      name: 'showFirstLast / showPreviousNext / showPageInfo',
      type: 'bool',
      description: 'Toggle jump-to-first/last controls, previous/next controls, and the “Página X de Y” label. First/last controls are hidden in compact layout.',
      defaultValue: 'true / true / false',
    ),
    ClayProp(
      name: 'compact',
      type: 'bool',
      description: 'Use previous, current/total, and next controls. This layout is also chosen automatically when available width is below 360 logical pixels.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'buttonSize / spacing / borderRadius',
      type: 'double',
      description: 'Set the square size of page controls, gap between controls, and their corner radius.',
      defaultValue: '38 / 6 / 12',
    ),
    ClayProp(
      name: 'activeColor / activeForegroundColor',
      type: 'Color?',
      description: 'Selected page background and its text color. Defaults to theme primary and onPrimary.',
      defaultValue: 'theme.primary / theme.onPrimary',
    ),
    ClayProp(
      name: 'backgroundColor / foregroundColor / disabledColor',
      type: 'Color?',
      description: 'Unselected control surface and text, plus disabled arrow color. Defaults use theme container, onContainer, and a subdued onBackgroundVariant.',
      defaultValue: 'theme.container / theme.onContainer / theme.onBackgroundVariant at 38%',
    ),
  ],
);
