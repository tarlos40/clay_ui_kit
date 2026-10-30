import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc cardDocumentation = ComponentDoc(
  title: 'Card',
  subtitle: 'Components',
  description: 'A configurable surface for grouping related content. Compose header, body, and footer sections, or use helpers for text, menus, buttons, and expandable images.',
  legends: [
    DocumentationLegend(
      label: 'Header / Body / Footer',
      color: ClayColors.cobalt.s500,
    ),
    DocumentationLegend(label: 'Interactive', color: ClayColors.sky.s500),
    DocumentationLegend(label: 'Image Viewer', color: ClayColors.violet.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Build a Card from Sections',
      description: 'Use header for identity and a contextual action, body for the main content, and footer for supporting metadata and buttons. A custom header child replaces its title and subtitle.',
      code: '''
ClayCard(
  children: [
    ClayCard.header(
      title: 'Mobile refresh',
      subtitle: 'Updated 5 minutes ago',
      leading: Icon(Icons.folder_outlined),
      action: ClayCard.action(
        menu: [
          ClayCard.menu(title: 'Rename', onPressed: _renameProject),
          ClayCard.menu(title: 'Archive', onPressed: _archiveProject),
        ],
      ),
    ),
    ClayCard.body(
      children: [
        ClayCard.label('IN PROGRESS'),
        ClayCard.title('Improve the mobile experience'),
        ClayCard.subtitle('Design and implementation tasks for the next release.'),
      ],
    ),
    ClayCard.footer(
      leading: ClayCard.label('Due Friday'),
      buttons: [
        ClayCard.button(label: 'Details', onPressed: _showDetails),
        ClayCard.button(
          label: 'Open project',
          primary: true,
          iconRight: Icon(Icons.arrow_forward_rounded),
          onPressed: _openProject,
        ),
      ],
    ),
  ],
)
''',
      preview: ClayCard(
        children: [
          ClayCard.header(
            title: 'Mobile refresh',
            subtitle: 'Updated 5 minutes ago',
            leading: const Icon(Icons.folder_outlined),
            action: ClayCard.action(
              menu: [
                ClayCard.menu(title: 'Rename', onPressed: () {}),
                ClayCard.menu(title: 'Archive', onPressed: () {}),
              ],
            ),
          ),
          ClayCard.body(
            children: [
              ClayCard.label('IN PROGRESS'),
              ClayCard.title('Improve the mobile experience'),
              ClayCard.subtitle(
                'Design and implementation tasks for the next release.',
              ),
            ],
          ),
          ClayCard.footer(
            leading: ClayCard.label('Due Friday'),
            buttons: [
              ClayCard.button(label: 'Details', onPressed: () {}),
              ClayCard.button(
                label: 'Open project',
                primary: true,
                iconRight: const Icon(Icons.arrow_forward_rounded),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Surface Interaction and Styling',
      description: 'onTap makes the surface clickable. hoverable enables pointer scale feedback, and onHover reports pointer entry and exit. enabled: false suppresses card interactions without fading its appearance.',
      code: '''
ClayCard(
  onTap: _openProject,
  hoverable: true,
  onHover: (isHovered) => debugPrint('Hovered: \$isHovered'),
  backgroundColor: ClayColors.cobalt.s50,
  padding: EdgeInsets.all(20),
  margin: EdgeInsets.only(bottom: 12),
  borderRadius: 16,
  border: Border.all(color: ClayColors.cobalt.s200),
  boxShadow: const [],
  children: [
    ClayCard.title('Open project'),
    ClayCard.subtitle('Tap the card to continue.'),
  ],
)

ClayCard(
  enabled: false,
  onTap: _openProject,
  children: [ClayCard.title('Unavailable project')],
)
''',
      preview: Column(
        children: [
          ClayCard(
            onTap: () {},
            hoverable: true,
            onHover: (_) {},
            backgroundColor: ClayColors.cobalt.s50,
            margin: const EdgeInsets.only(bottom: 12),
            borderRadius: 16,
            border: Border.all(color: ClayColors.cobalt.s200),
            boxShadow: const [],
            children: [
              ClayCard.title('Open project'),
              ClayCard.subtitle('Tap the card to continue.'),
            ],
          ),
          ClayCard(
            enabled: false,
            onTap: () {},
            children: [ClayCard.title('Unavailable project')],
          ),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Images and Contextual Menus',
      description: 'ClayCard.image requires exactly one image or child. expandable opens a full-screen viewer with pan and zoom. heroTag animates ImageProvider content only. Put ClayCard.action in a header to open a menu of ClayCard.menu entries.',
      code: '''
ClayCard(
  children: [
    ClayCard.image(
      child: ColoredBox(
        color: ClayColors.cobalt.s100,
        child: SizedBox(
          height: 150,
          child: Center(child: Icon(Icons.photo_outlined)),
        ),
      ),
      height: 150,
      expandable: true,
      showCloseButton: true,
    ),
    ClayCard.header(
      title: 'Project files',
      subtitle: '3 items',
      action: ClayCard.action(
        menu: [
          ClayCard.menu(
            title: 'Rename',
            subtitle: 'Change the project name',
            icon: Icon(Icons.edit_outlined),
            onPressed: _renameProject,
          ),
          ClayCard.menu(
            title: 'Delete',
            icon: Icon(Icons.delete_outline),
            enabled: false,
          ),
        ],
      ),
    ),
  ],
)
''',
      preview: ClayCard(
        children: [
          ClayCard.image(
            child: ColoredBox(
              color: ClayColors.cobalt.s100,
              child: const SizedBox(
                height: 150,
                child: Center(child: Icon(Icons.photo_outlined)),
              ),
            ),
            height: 150,
            expandable: true,
            showCloseButton: true,
          ),
          ClayCard.header(
            title: 'Project files',
            subtitle: '3 items',
            action: ClayCard.action(
              menu: [
                ClayCard.menu(
                  title: 'Rename',
                  subtitle: 'Change the project name',
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () {},
                ),
                ClayCard.menu(
                  title: 'Delete',
                  icon: const Icon(Icons.delete_outline),
                  enabled: false,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'children',
      type: 'List<Widget>',
      description: 'Required widgets rendered vertically in order. Compose them from sections such as header, body, image, and footer.',
      required: true,
    ),
    ClayProp(
      name: 'backgroundColor / backgroundGradient',
      type: 'Color? / Gradient?',
      description: 'Choose one card background. Supplying both triggers an assertion; when neither is set, the theme container color is used.',
      defaultValue: 'theme.container / null',
    ),
    ClayProp(
      name: 'padding / margin',
      type: 'EdgeInsetsGeometry?',
      description: 'Card-level content padding and outer margin. Both default to null; section helpers add their own padding.',
      defaultValue: 'null / null',
    ),
    ClayProp(
      name: 'width / height / constraints',
      type: 'double? / double? / BoxConstraints?',
      description:
          'Optional dimensions and constraints applied to the card surface.',
      defaultValue: 'null / null / null',
    ),
    ClayProp(
      name: 'borderRadius / border / boxShadow',
      type: 'double / Border? / List<BoxShadow>?',
      description: 'Configure corner radius, outline, and outer shadows. Null border uses no explicit outline; null boxShadow uses themed shadows.',
      defaultValue: '24 / null / theme shadows',
    ),
    ClayProp(
      name: 'clipBehavior',
      type: 'Clip',
      description:
          'Controls clipping of the surface contents, including images.',
      defaultValue: 'Clip.antiAlias',
    ),
    ClayProp(
      name: 'onTap / enabled',
      type: 'VoidCallback? / bool',
      description: 'onTap handles a surface tap. enabled false disables tap and hover handling but does not fade the card.',
      defaultValue: 'null / true',
    ),
    ClayProp(
      name: 'hoverable / onHover',
      type: 'bool / ValueChanged<bool>?',
      description: 'hoverable enables pointer scale feedback; onHover reports true on entry and false on exit.',
      defaultValue: 'false / null',
    ),
    ClayProp(
      name: 'ClayCard.header',
      type: 'static helper',
      description: 'Accepts title, subtitle, leading, action, child, and padding. Without child it renders title/subtitle; child replaces both text fields.',
      defaultValue: 'EdgeInsets.fromLTRB(20, 20, 20, 12)',
    ),
    ClayProp(
      name: 'ClayCard.body',
      type: 'static helper',
      description: 'Requires children and lays them out in a vertically stretched column.',
      defaultValue: 'EdgeInsets.symmetric(horizontal: 20, vertical: 12)',
    ),
    ClayProp(
      name: 'ClayCard.footer',
      type: 'static helper',
      description: 'Accepts leading, child, trailing, buttons, and padding. Child expands, and buttons wrap at the end of the row.',
      defaultValue: 'EdgeInsets.fromLTRB(20, 12, 20, 20)',
    ),
    ClayProp(
      name: 'ClayCard.title / subtitle / label',
      type: 'static helpers',
      description: 'Require text and accept color, fontWeight, and padding. They render title, body-style supporting text, and subdued label text.',
      defaultValue: 'FontWeight.w700 / w500 / w600',
    ),
    ClayProp(
      name: 'ClayCard.action',
      type: 'static helper',
      description: 'Requires a menu list of ClayCard.menu widgets. The icon and padding can be customized.',
      defaultValue: 'Icons.more_vert_rounded / EdgeInsets.all(8)',
    ),
    ClayProp(
      name: 'ClayCard.menu',
      type: 'static helper',
      description: 'Requires title; subtitle, icon, trailing, and onPressed are optional. enabled false disables the menu entry.',
      defaultValue: 'enabled: true',
    ),
    ClayProp(
      name: 'ClayCard.button',
      type: 'static helper',
      description: 'Requires label and onPressed. primary true selects primary styling; otherwise it uses tertiary styling. Optional iconLeft and iconRight flank the label.',
      defaultValue: 'primary: false',
    ),
    ClayProp(
      name: 'ClayCard.image',
      type: 'static helper',
      description: 'Provide exactly one of image or child. expandable opens a pan-and-zoom viewer; heroTag animates ImageProvider content only, and showCloseButton controls the viewer close control.',
      defaultValue: 'BoxFit.cover / 18px radius / Alignment.center / EdgeInsets.zero / expandable false / showCloseButton true',
    ),
  ],
);
