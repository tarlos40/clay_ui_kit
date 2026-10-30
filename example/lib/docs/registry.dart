import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import './classes/models.dart';
import './foundations/colors.dart';
import './foundations/palette.dart';
import './foundations/typography.dart';
import './foundations/containers.dart';
import './foundations/shadows.dart';
import './foundations/theme.dart';
import './foundations/scaffold.dart';
import './foundations/refresh_indicator.dart';
import './components/app_bar.dart';
import './components/accordion.dart';
import './components/avatar.dart';
import './components/badge.dart';
import './components/button.dart';
import './components/breadcrumb.dart';
import './components/drawer.dart';
import './components/floating_action_button.dart';
import './components/menu.dart';
import './components/modal.dart';
import './components/navigation_bar.dart';
import './components/pagination.dart';
import './components/sheet.dart';
import './components/tabs.dart';
import './components/tooltip.dart';
import './components/checkbox.dart';
import './components/date_pick.dart';
import './components/input.dart';
import './components/input_search.dart';
import './components/radio.dart';
import './components/slider.dart';
import './components/switch.dart';
import './components/text_area.dart';
import './components/feedback.dart';
import './components/loading.dart';
import './components/progress.dart';
import './components/card.dart';
import './components/carousel.dart';
import './components/props_table.dart';
import './components/table.dart';
import './components/show_case.dart';
import './components/skeleton.dart';
import './components/toast.dart';
import './components/upload.dart';

class ComponentDocRegistry {
  static final Map<String, ComponentDoc> docs = {
    'colors': colorsDocumentation,
    'palette': paletteDocumentation,
    'typography': typographyDocumentation,
    'containers': containersDocumentation,
    'shadows': shadowsDocumentation,
    'theme': themeDocumentation,
    'scaffold': scaffoldDocumentation,
    'refresh-indicator': refreshIndicatorDocumentation,
    'app-bar': appBarDocumentation,
    'accordion': accordionDocumentation,
    'avatar': avatarDocumentation,
    'badge': badgeDocumentation,
    'button': buttonDocumentation,
    'breadcrumb': breadcrumbDocumentation,
    'card': cardDocumentation,
    'carousel': carouselDocumentation,
    'checkbox': checkboxDocumentation,
    'date-pick': datePickDocumentation,
    'drawer': drawerDocumentation,
    'feedback': feedbackDocumentation,
    'floating-action-button': floatingActionButtonDocumentation,
    'input': inputDocumentation,
    'input-search': inputSearchDocumentation,
    'loading': loadingDocumentation,
    'menu': menuDocumentation,
    'modal': modalDocumentation,
    'navigation-bar': navigationBarDocumentation,
    'pagination': paginationDocumentation,
    'progress': progressDocumentation,
    'props-table': propsTableDocumentation,
    'radio': radioDocumentation,
    'sheet': sheetDocumentation,
    'show-case': showCaseDocumentation,
    'skeleton': skeletonDocumentation,
    'slider': sliderDocumentation,
    'switch': switchDocumentation,
    'table': tableDocumentation,
    'tabs': tabsDocumentation,
    'text-area': textAreaDocumentation,
    'toast': toastDocumentation,
    'tooltip': tooltipDocumentation,
    'upload': uploadDocumentation,
  };

  static ComponentDoc resolve(BuildContext context, String slug) {
    final theme = context.clayTheme;

    final normalized = slug.trim().toLowerCase().replaceAll(
      RegExp(r'[^a-z0-9-]+'),
      '-',
    );

    return docs[normalized] ??
        ComponentDoc(
          title: _humanize(normalized),
          subtitle: 'Documentation',
          description: 'This documentation has not yet been added, but the generic structure is already in place to receive the next component.',
          legends: [
            DocumentationLegend(label: 'Not Available', color: theme.error),
          ],
          showcases: const [],
          props: const [
            ClayProp(
              name: 'TODO',
              type: 'dynamic',
              description: 'Fill in the component properties here.',
              defaultValue: 'null',
            ),
          ],
        );
  }

  static String _humanize(String value) {
    if (value.isEmpty) return 'Component';

    final words = value
        .split('-')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .toList();

    if (words.isEmpty) return 'Component';
    return words.join(' ');
  }
}
