import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc inputSearchDocumentation = ComponentDoc(
  title: 'Input Search',
  subtitle: 'Components',
  description: 'A search field with separate query, submission, and suggestion-selection callbacks, plus a filtered suggestion panel and configurable controls.',
  legends: [
    DocumentationLegend(label: 'Query', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Suggestions', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Submit', color: ClayColors.forest.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Search with Suggestions',
      description: 'Suggestions are matched case-insensitively against title and subtitle. Selecting one writes value (or title when value is null) into the field, calls onQueryChanged and onSuggestionSelected, then closes the panel.',
      code: '''
ClayInput.search(
  label: 'Find a project',
  hintText: 'Search projects...',
  suggestions: const [
    ClaySearchSuggestion(
      title: 'Clay UI Kit',
      subtitle: 'Design system',
      leading: Icon(Icons.widgets_outlined),
      trailing: Icon(Icons.north_east_rounded),
      value: 'clay-ui-kit',
    ),
    ClaySearchSuggestion(
      title: 'Mobile refresh',
      subtitle: 'Application',
      leading: Icon(Icons.phone_android_rounded),
    ),
  ],
  onQueryChanged: (query) => debugPrint('Query: ' + query),
  onSuggestionSelected: (suggestion) => debugPrint(suggestion.title),
  onSearch: (query) => debugPrint('Submit: ' + query),
)
''',
      preview: ClayInput.search(
        label: 'Find a project',
        hintText: 'Search projects...',
        suggestions: const [
          ClaySearchSuggestion(
            title: 'Clay UI Kit',
            subtitle: 'Design system',
            leading: Icon(Icons.widgets_outlined),
          ),
          ClaySearchSuggestion(
            title: 'Mobile refresh',
            subtitle: 'Application',
            leading: Icon(Icons.phone_android_rounded),
          ),
        ],
        onQueryChanged: (_) {},
        onSuggestionSelected: (_) {},
        onSearch: (_) {},
      ),
    ),
    ClayShowcase(
      title: 'Configure Search Controls',
      description: 'The search button is icon-only by default through ClayInput.search; set searchButtonLabel to show text. The clear control appears only for non-empty text. Suggestions can be hidden on initial focus and capped with maxSuggestions.',
      code: '''
ClayInput.search(
  label: 'Search members',
  hintText: 'Name or team',
  showSearchButton: true,
  searchButtonLabel: 'Find',
  showSuggestionsOnFocus: false,
  clearable: true,
  maxSuggestions: 3,
  searchIcon: Icon(Icons.manage_search_rounded),
  accentColor: ClayColors.forest.s600,
  backgroundColor: ClayColors.forest.s50,
  onSearch: _findMembers,
)
''',
      preview: ClayInput.search(
        label: 'Search members',
        hintText: 'Name or team',
        showSearchButton: true,
        searchButtonLabel: 'Find',
        showSuggestionsOnFocus: false,
        clearable: true,
        maxSuggestions: 3,
        searchIcon: const Icon(Icons.manage_search_rounded),
        accentColor: ClayColors.forest.s600,
        backgroundColor: ClayColors.forest.s50,
        onSearch: (_) {},
      ),
    ),
    ClayShowcase(
      title: 'Submit Without a Button',
      description: 'Hide the submit button to rely on the keyboard search action. Submission trims surrounding whitespace and ignores an empty query; clearing sends an empty string to onQueryChanged and keeps focus.',
      code: '''
ClayInput.search(
  hintText: 'Search documentation',
  showSearchButton: false,
  clearable: true,
  suggestions: const [
    ClaySearchSuggestion(title: 'Getting started', value: '/getting-started'),
    ClaySearchSuggestion(title: 'Components', value: '/components'),
  ],
  onQueryChanged: _updateQuery,
  onSuggestionSelected: _openSuggestion,
  onSearch: _searchDocumentation,
)
''',
      preview: ClayInput.search(
        hintText: 'Search documentation',
        showSearchButton: false,
        clearable: true,
        suggestions: const [
          ClaySearchSuggestion(
            title: 'Getting started',
            value: '/getting-started',
          ),
          ClaySearchSuggestion(title: 'Components', value: '/components'),
        ],
        onQueryChanged: (_) {},
        onSuggestionSelected: (_) {},
        onSearch: (_) {},
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'controller / focusNode',
      type: 'TextEditingController? / FocusNode?',
      description: 'Optional external editing and focus controls. The widget creates and disposes its own when omitted.',
      defaultValue: 'null / null',
    ),
    ClayProp(
      name: 'label / hintText',
      type: 'String?',
      description: 'Optional field label and placeholder. ClayInput.search has no default hint text unless one is passed.',
      defaultValue: 'null / null',
    ),
    ClayProp(
      name: 'suggestions',
      type: 'List<ClaySearchSuggestion>',
      description: 'Suggestion entries with title, optional subtitle, icons, and custom value.',
      defaultValue: 'const []',
    ),
    ClayProp(
      name: 'onQueryChanged',
      type: 'ValueChanged<String>?',
      description: 'Called with each typed query, with the selected suggestion queryValue, and with an empty string when cleared.',
    ),
    ClayProp(
      name: 'onSuggestionSelected',
      type: 'ValueChanged<ClaySearchSuggestion>?',
      description: 'Called with the selected suggestion after its queryValue is written to the field. Selection also calls onQueryChanged.',
    ),
    ClayProp(
      name: 'onSearch',
      type: 'ValueChanged<String>?',
      description: 'Called from the search button or keyboard action with trimmed, non-empty query text; submission closes suggestions and unfocuses the field.',
    ),
    ClayProp(
      name: 'showSearchButton / showSuggestionsOnFocus / clearable',
      type: 'bool',
      description: 'Show the submit button, display suggestions when focused with an empty query, and show a clear control for non-empty text.',
      defaultValue: 'true / true / true',
    ),
    ClayProp(
      name: 'maxSuggestions',
      type: 'int',
      description:
          'Maximum number of matching suggestions. Must be greater than zero.',
      defaultValue: '6',
    ),
    ClayProp(
      name: 'searchButtonLabel / searchIcon',
      type: 'String / Widget?',
      description: 'The label is empty by default via ClayInput.search, making the button icon-only. searchIcon customizes both the leading search symbol and button icon.',
      defaultValue: "'' / default search and arrow icons",
    ),
    ClayProp(
      name: 'backgroundColor / accentColor / textColor / hintColor',
      type: 'Color?',
      description: 'Customize the field and suggestion panel surface, focus/button accent, entered text, and hint/suggestion secondary text.',
      defaultValue: 'theme colors',
    ),
    ClayProp(
      name: 'borderRadius',
      type: 'double',
      description: 'Corner radius for the field and search button.',
      defaultValue: '40',
    ),
    ClayProp(
      name: 'ClaySearchSuggestion.title / subtitle',
      type: 'String / String?',
      description: 'Required primary suggestion text and optional secondary text. Both are searched case-insensitively.',
    ),
    ClayProp(
      name: 'ClaySearchSuggestion.leading / trailing',
      type: 'Widget? / Widget?',
      description:
          'Optional widgets shown before and after the suggestion text.',
    ),
    ClayProp(
      name: 'ClaySearchSuggestion.value',
      type: 'String?',
      description: 'Value placed into the query when selected; defaults to title. Filtering still matches title and subtitle.',
      defaultValue: 'title',
    ),
  ],
);
