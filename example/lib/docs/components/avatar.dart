import 'package:clay_ui_kit/clay_ui_kit.dart';
import 'package:flutter/material.dart';

import '../classes/models.dart';

ComponentDoc avatarDocumentation = ComponentDoc(
  title: 'Avatar',
  subtitle: 'Components',
  description: 'Circular identity elements that display a person, image, icon, initials, or custom content.',
  legends: [
    DocumentationLegend(label: 'Initials', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Icon / Image', color: ClayColors.violet.s500),
    DocumentationLegend(label: 'Status Badge', color: ClayColors.forest.s500),
    DocumentationLegend(label: 'Avatar Group', color: ClayColors.amber.s500),
  ],
  showcases: [
    ClayShowcase(
      title: 'Initials and Sizes',
      description: 'Provide a name to derive initials, then select a preset size or set a custom radius.',
      code: '''
Wrap(
  spacing: 12,
  children: [
    ClayAvatar(name: 'Ada Lovelace', size: ClayAvatarSize.small),
    ClayAvatar(name: 'Grace Hopper'),
    ClayAvatar(name: 'Katherine Johnson', size: ClayAvatarSize.large),
  ],
)
''',
      preview: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: const [
          ClayAvatar(name: 'Ada Lovelace', size: ClayAvatarSize.small),
          ClayAvatar(name: 'Grace Hopper'),
          ClayAvatar(name: 'Katherine Johnson', size: ClayAvatarSize.large),
        ],
      ),
    ),
    ClayShowcase(
      title: 'Icon and Status Badge',
      description: 'Use an icon in place of initials and provide a badge widget to overlay a status indicator.',
      code: '''
ClayAvatar(
  icon: Icon(Icons.person_outline_rounded),
  randomColor: true,
  randomSeed: 7,
  size: ClayAvatarSize.large,
  badge: Align(
    alignment: Alignment.topRight,
    child: Icon(Icons.verified_rounded, color: Colors.green),
  ),
)
''',
      preview: ClayAvatar(
        icon: const Icon(Icons.person_outline_rounded),
        randomColor: true,
        randomSeed: 7,
        size: ClayAvatarSize.large,
        badge: const Align(
          alignment: Alignment.topRight,
          child: Icon(Icons.verified_rounded, color: Colors.green),
        ),
      ),
    ),
    ClayShowcase(
      title: 'Avatar Group',
      description: 'ClayAvatar.group overlaps avatars and can add a remaining-count indicator when maxVisible is exceeded.',
      code: '''
ClayAvatar.group(
  overlap: 12,
  maxVisible: 3,
  children: [
    ClayAvatar(name: 'Ada Lovelace'),
    ClayAvatar(name: 'Grace Hopper'),
    ClayAvatar(name: 'Katherine Johnson'),
    ClayAvatar(name: 'Dorothy Vaughan'),
  ],
)
''',
      preview: ClayAvatar.group(
        overlap: 12,
        maxVisible: 3,
        children: const [
          ClayAvatar(name: 'Ada Lovelace'),
          ClayAvatar(name: 'Grace Hopper'),
          ClayAvatar(name: 'Katherine Johnson'),
          ClayAvatar(name: 'Dorothy Vaughan'),
        ],
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'name',
      type: 'String?',
      description: 'Name used to generate initials when label, image, child, and icon are not provided.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'label',
      type: 'String?',
      description:
          'Custom text displayed in the avatar instead of generated initials.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'icon',
      type: 'Widget?',
      description:
          'Icon displayed inside the avatar. Cannot be combined with image.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'image',
      type: 'ImageProvider?',
      description:
          'Image displayed inside the avatar. Cannot be combined with icon.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'child',
      type: 'Widget?',
      description: 'Custom content displayed centered inside the avatar.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'badge',
      type: 'Widget?',
      description:
          'Widget overlaid on top of the avatar; pointer events are ignored.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'backgroundColor',
      type: 'Color?',
      description: 'Avatar background color. Defaults to a generated color when randomColor is true, or the theme primary color otherwise.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'foregroundColor',
      type: 'Color?',
      description: 'Foreground color used for generated initials and icon theme. Defaults to the theme on-primary color.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'randomColor',
      type: 'bool',
      description:
          'Whether to generate avatar background and foreground colors.',
      defaultValue: 'false',
    ),
    ClayProp(
      name: 'randomSeed',
      type: 'int?',
      description: 'Optional seed passed to the random color generator.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'size',
      type: 'ClayAvatarSize',
      description: 'Preset avatar size: small (36 px), medium (48 px), large (64 px), or extraLarge (88 px). Ignored when radius is set.',
      defaultValue: 'ClayAvatarSize.medium',
    ),
    ClayProp(
      name: 'radius',
      type: 'double?',
      description: 'Custom radius in logical pixels; the avatar diameter is twice this value.',
      defaultValue: 'null',
    ),
    ClayProp(
      name: 'children (ClayAvatar.group)',
      type: 'List<ClayAvatar>',
      description: 'Avatars included in the group.',
      required: true,
    ),
    ClayProp(
      name: 'overlap (ClayAvatar.group)',
      type: 'double',
      description: 'Horizontal overlap between neighboring avatars.',
      defaultValue: '12',
    ),
    ClayProp(
      name: 'alignment (ClayAvatar.group)',
      type: 'MainAxisAlignment',
      description: 'Alignment value accepted by the group. Avatar positioning currently starts from the left.',
      defaultValue: 'MainAxisAlignment.start',
    ),
    ClayProp(
      name: 'maxVisible (ClayAvatar.group)',
      type: 'int?',
      description: 'Maximum number of avatars to display before showing a remaining-count indicator. Must be greater than zero when provided.',
      defaultValue: 'null',
    ),
  ],
);
