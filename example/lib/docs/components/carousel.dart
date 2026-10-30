import 'package:flutter/material.dart';
import 'package:clay_ui_kit/clay_ui_kit.dart';

import '../classes/models.dart';

ComponentDoc carouselDocumentation = ComponentDoc(
  title: 'Carousel',
  subtitle: 'Components',
  description: 'A paged sequence of image or widget-backed slides, with configurable navigation, indicators, autoplay, and per-slide content.',
  legends: [
    DocumentationLegend(label: 'Arrows', color: ClayColors.cobalt.s500),
    DocumentationLegend(label: 'Dots / Progress', color: ClayColors.sky.s500),
    DocumentationLegend(
      label: 'Autoplay / Infinite',
      color: ClayColors.violet.s500,
    ),
  ],
  showcases: [
    ClayShowcase(
      title: 'Create Slides',
      description: 'Each item needs an image or background. Use the carousel callbacks to observe page changes and taps across the slides.',
      code: '''
ClayCarousel(
  height: 240,
  showArrows: true,
  showDots: true,
  infinite: false,
  onPageChanged: (index) => debugPrint('Page: \$index'),
  onItemTap: (index) => debugPrint('Tapped: \$index'),
  items: [
    ClayCarouselItem(
      background: ColoredBox(color: ClayColors.cobalt.s500),
      tag: 'WORKSPACE',
      title: 'One place for your work',
      description: 'A slide can pair a visual with concise supporting content.',
    ),
    ClayCarouselItem(
      background: ColoredBox(color: ClayColors.forest.s500),
      title: 'Keep moving forward',
    ),
  ],
)
''',
      preview: SizedBox(
        height: 240,
        child: ClayCarousel(
          height: 240,
          showArrows: true,
          showDots: true,
          infinite: false,
          items: const [
            ClayCarouselItem(
              background: ColoredBox(color: Color(0xFF174A9C)),
              tag: 'WORKSPACE',
              title: 'One place for your work',
              description:
                  'Visual slides can include concise supporting content.',
            ),
            ClayCarouselItem(
              background: ColoredBox(color: Color(0xFF2E6F40)),
              title: 'Keep moving forward',
            ),
          ],
        ),
      ),
    ),
    ClayShowcase(
      title: 'Slide Content and Buttons',
      description: 'Slides can include a tag, subtitle, title, description, buttons, and their own tap callback. An item callback takes precedence over onItemTap for that slide.',
      code: '''
ClayCarousel(
  height: 280,
  viewportFraction: 0.88,
  spacing: 12,
  onItemTap: (index) => debugPrint('Tapped slide \$index'),
  items: [
    ClayCarouselItem(
      background: ColoredBox(color: ClayColors.cobalt.s700),
      tag: 'FEATURED',
      subtitle: 'A focused workspace',
      title: 'Everything in one place',
      description: 'Open the slide or use its action.',
      gradient: true,
      contentAlignment: Alignment.bottomLeft,
      buttons: [
        ClayCarouselButton(
          label: 'Explore',
          icon: Icon(Icons.arrow_forward_rounded),
          primary: true,
          onPressed: () {},
        ),
      ],
      onTap: () => debugPrint('Featured slide'),
    ),
    ClayCarouselItem(
      background: ColoredBox(color: ClayColors.forest.s600),
      title: 'A second slide',
      gradient: false,
    ),
  ],
)
''',
      preview: SizedBox(
        height: 280,
        child: ClayCarousel(
          height: 280,
          viewportFraction: 0.88,
          spacing: 12,
          onItemTap: (_) {},
          items: [
            ClayCarouselItem(
              background: ColoredBox(color: ClayColors.cobalt.s700),
              tag: 'FEATURED',
              subtitle: 'A focused workspace',
              title: 'Everything in one place',
              description: 'Open the slide or use its action.',
              gradient: true,
              contentAlignment: Alignment.bottomLeft,
              buttons: [
                ClayCarouselButton(
                  label: 'Explore',
                  icon: const Icon(Icons.arrow_forward_rounded),
                  primary: true,
                  onPressed: () {},
                ),
              ],
              onTap: () {},
            ),
            ClayCarouselItem(
              background: ColoredBox(color: ClayColors.forest.s600),
              title: 'A second slide',
              gradient: false,
            ),
          ],
        ),
      ),
    ),
    ClayShowcase(
      title: 'Autoplay and Indicators',
      description: 'Autoplay advances at the configured interval. When showProgress is true, the progress indicator is shown instead of dots.',
      code: '''
ClayCarousel(
  height: 180,
  autoplay: true,
  autoplayInterval: Duration(seconds: 5),
  animationDuration: Duration(milliseconds: 500),
  showArrows: false,
  showDots: false,
  showProgress: true,
  indicatorAlignment: Alignment.bottomRight,
  indicatorPadding: EdgeInsets.all(16),
  items: [
    ClayCarouselItem(background: ColoredBox(color: ClayColors.cobalt.s500)),
    ClayCarouselItem(background: ColoredBox(color: ClayColors.forest.s500)),
  ],
)
''',
      preview: SizedBox(
        height: 180,
        child: ClayCarousel(
          height: 180,
          autoplay: true,
          autoplayInterval: const Duration(seconds: 5),
          animationDuration: const Duration(milliseconds: 500),
          showArrows: false,
          showDots: false,
          showProgress: true,
          indicatorAlignment: Alignment.bottomRight,
          indicatorPadding: const EdgeInsets.all(16),
          items: [
            ClayCarouselItem(
              background: ColoredBox(color: ClayColors.cobalt.s500),
            ),
            ClayCarouselItem(
              background: ColoredBox(color: ClayColors.forest.s500),
            ),
          ],
        ),
      ),
    ),
  ],
  props: const [
    ClayProp(
      name: 'items',
      type: 'List<ClayCarouselItem>',
      description: 'Slides; each item needs an image or background.',
      required: true,
    ),
    ClayProp(
      name: 'initialPage / height / aspectRatio',
      type: 'int / double / double?',
      description: 'Initial slide and sizing. aspectRatio takes precedence over height when provided.',
      defaultValue: '0 / 320 / null',
    ),
    ClayProp(
      name: 'showArrows / showDots / showProgress',
      type: 'bool',
      description: 'Toggle navigation controls and indicators.',
      defaultValue: 'true / true / false',
    ),
    ClayProp(
      name: 'infinite / autoplay / autoplayInterval',
      type: 'bool / bool / Duration',
      description:
          'Enable looping and timed page changes at the given interval.',
      defaultValue: 'true / false / 4 seconds',
    ),
    ClayProp(
      name: 'animationDuration',
      type: 'Duration',
      description:
          'Duration used for page transitions and indicator animations.',
      defaultValue: '420 milliseconds',
    ),
    ClayProp(
      name: 'viewportFraction / spacing / padding',
      type: 'double / double / EdgeInsetsGeometry',
      description:
          'Configure slide width, gap between slides, and outer inset.',
      defaultValue: '1 / 0 / EdgeInsets.zero',
    ),
    ClayProp(
      name: 'borderRadius / clipBehavior',
      type: 'double / Clip',
      description: 'Configure the carousel shape and clipping behavior.',
      defaultValue: '24 / Clip.antiAlias',
    ),
    ClayProp(
      name: 'arrowSize / arrowInset',
      type: 'double',
      description: 'Set the navigation arrow diameter and inset from the edge.',
      defaultValue: '42 / 12',
    ),
    ClayProp(
      name: 'indicatorAlignment / indicatorPadding',
      type: 'Alignment / EdgeInsetsGeometry',
      description:
          'Position the dots or progress indicator within the carousel.',
      defaultValue: 'Alignment.bottomCenter / EdgeInsets.only(bottom: 14)',
    ),
    ClayProp(
      name: 'onPageChanged / onItemTap',
      type: 'ValueChanged<int>?',
      description: 'Callbacks receive the selected slide index. A ClayCarouselItem.onTap callback takes precedence for that item.',
    ),
    ClayProp(
      name: 'ClayCarouselItem.image / background',
      type: 'ImageProvider? / Widget?',
      description: 'Visual source for each slide; provide one of these.',
    ),
    ClayProp(
      name: 'ClayCarouselItem.tag / subtitle / title / description',
      type: 'String?',
      description: 'Optional text fields displayed over the slide.',
    ),
    ClayProp(
      name: 'ClayCarouselItem.gradient / gradientColors / overlayColor',
      type: 'bool / List<Color>? / Color?',
      description:
          'Configure the default text gradient and an optional color overlay.',
      defaultValue: 'true / null / null',
    ),
    ClayProp(
      name:
          'ClayCarouselItem.contentAlignment / contentPadding / contentSpacing',
      type: 'Alignment / EdgeInsetsGeometry / double',
      description: 'Position and space the slide content.',
      defaultValue:
          'Alignment.bottomLeft / EdgeInsets.fromLTRB(24, 24, 24, 38) / 8',
    ),
    ClayProp(
      name: 'ClayCarouselItem.buttons / buttonSpacing',
      type: 'List<ClayCarouselButton> / double',
      description: 'Add action buttons and configure their wrap spacing.',
      defaultValue: 'const [] / 10',
    ),
    ClayProp(
      name: 'ClayCarouselItem.onTap / borderRadius / imageFit',
      type: 'VoidCallback? / double? / BoxFit',
      description: 'Handle a slide tap, override its corner radius, and set image fitting.',
      defaultValue: 'null / null / BoxFit.cover',
    ),
    ClayProp(
      name: 'ClayCarouselButton.label / onPressed / icon / primary',
      type: 'String / VoidCallback? / Widget? / bool',
      description:
          'Configure a slide button, its leading icon, and primary style.',
      defaultValue: 'required / required / null / false',
    ),
    ClayProp(
      name: 'ClayCarouselButton.backgroundColor / foregroundColor / padding',
      type: 'Color? / Color? / EdgeInsetsGeometry?',
      description: 'Constructor fields currently not applied when the carousel button is built.',
    ),
  ],
);
