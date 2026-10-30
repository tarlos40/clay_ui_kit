import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../text/scripts/text.dart';
import '../../../utils/random_colors.dart';
import '../types/size.dart';
import '../../../theme/scripts/shadows.dart';

class ClayAvatar extends StatelessWidget {
  final String? name;
  final String? label;
  final Widget? icon;
  final ImageProvider? image;
  final Widget? child;
  final Widget? badge;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final bool randomColor;
  final int? randomSeed;

  final ClayAvatarSize size;
  final double? radius;

  const ClayAvatar({
    super.key,
    this.name,
    this.label,
    this.icon,
    this.image,
    this.child,
    this.badge,
    this.backgroundColor,
    this.foregroundColor,
    this.randomColor = false,
    this.randomSeed,
    this.size = ClayAvatarSize.medium,
    this.radius,
  }) : assert(
         image == null || icon == null,
         'ClayAvatar: image and icon cannot be used together.',
       );

  static Widget group({
    required List<ClayAvatar> children,
    double overlap = 12,
    MainAxisAlignment alignment = MainAxisAlignment.start,
    int? maxVisible,
  }) {
    return ClayAvatarGroup(
      overlap: overlap,
      alignment: alignment,
      maxVisible: maxVisible,
      children: children,
    );
  }

  double get dimension {
    if (radius != null) {
      return radius! * 2;
    }

    switch (size) {
      case ClayAvatarSize.small:
        return 36;

      case ClayAvatarSize.medium:
        return 48;

      case ClayAvatarSize.large:
        return 64;

      case ClayAvatarSize.extraLarge:
        return 88;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.clayTheme;

    final avatarSize = dimension;

    final random = randomColor
        ? RandomColors.random(context, seed: randomSeed)
        : null;

    final background =
        backgroundColor ?? random?.backgroundColor ?? theme.primary;

    final foreground =
        foregroundColor ?? random?.foregroundColor ?? theme.onPrimary;

    final content = _buildContent(
      context,
      background: background,
      foreground: foreground,
      size: avatarSize,
    );

    final avatar = CustomPaint(
      foregroundPainter: ClayInnerShadowPainter(
        shadowColor: theme.shadow,
        lightColor: theme.light,
        borderRadius: avatarSize / 2,
        shadowSize: 2.5,
        blurRadius: 7.0,
      ),
      child: Container(
        width: avatarSize,
        height: avatarSize,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          boxShadow: ClayShadows.external(theme: theme, offset: 1, blur: 3),
        ),
        child: ClipOval(
          child: SizedBox(
            width: avatarSize,
            height: avatarSize,
            child: content,
          ),
        ),
      ),
    );

    if (badge == null) {
      return avatar;
    }

    return SizedBox(
      width: avatarSize,
      height: avatarSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,

          Positioned.fill(child: IgnorePointer(ignoring: true, child: badge!)),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context, {
    required Color background,
    required Color foreground,
    required double size,
  }) {
    if (image != null) {
      return Image(image: image!, width: size, height: size, fit: BoxFit.cover);
    }

    if (child != null) {
      return ColoredBox(
        color: background,
        child: Center(child: child),
      );
    }

    if (icon != null) {
      return ColoredBox(
        color: background,
        child: Center(
          child: IconTheme(
            data: IconThemeData(size: size * 0.48, color: foreground),
            child: icon!,
          ),
        ),
      );
    }

    final text = label ?? (name != null ? _initials(name!) : '');

    return Center(
      child: ClayText.label(
        text,
        color: foreground,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  String _initials(String value) {
    final words = value
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();

    if (words.isEmpty) {
      return '';
    }

    if (words.length == 1) {
      final word = words.first;

      if (word.length == 1) {
        return word.toUpperCase();
      }

      return word.substring(0, 2).toUpperCase();
    }

    return '${words.first[0]}${words[1][0]}'.toUpperCase();
  }
}

class ClayAvatarGroup extends StatelessWidget {
  final List<ClayAvatar> children;
  final double overlap;
  final MainAxisAlignment alignment;
  final int? maxVisible;

  const ClayAvatarGroup({
    super.key,
    required this.children,
    this.overlap = 12,
    this.alignment = MainAxisAlignment.start,
    this.maxVisible,
  }) : assert(overlap >= 0, 'ClayAvatarGroup: overlap cannot be negative.'),
       assert(
         maxVisible == null || maxVisible > 0,
         'ClayAvatarGroup: maxVisible must be greater than zero.',
       );

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    final avatarSize = children.first.dimension;
    final limit = maxVisible ?? children.length;
    final hasOverflow = children.length > limit;

    final visibleAvatarCount = hasOverflow ? limit : children.length;
    final visibleCount = visibleAvatarCount + (hasOverflow ? 1 : 0);

    if (visibleCount == 1 && !hasOverflow) {
      return children.first;
    }

    final itemWidth = avatarSize - overlap;
    final width = avatarSize + ((visibleCount - 1) * itemWidth);

    return SizedBox(
      width: width,
      height: avatarSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (var index = 0; index < visibleAvatarCount; index++)
            Positioned(left: index * itemWidth, top: 0, child: children[index]),

          if (hasOverflow)
            Positioned(
              left: visibleAvatarCount * itemWidth,
              top: 0,
              child: _buildOverflowAvatar(
                context,
                size: avatarSize,
                remaining: children.length - visibleAvatarCount,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOverflowAvatar(
    BuildContext context, {
    required double size,
    required int remaining,
  }) {
    final theme = context.clayTheme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.primary,
        shape: BoxShape.circle,
        boxShadow: ClayShadows.external(theme: theme, offset: 2, blur: 5),
      ),
      child: CustomPaint(
        foregroundPainter: ClayInnerShadowPainter(
          shadowColor: theme.shadow,
          lightColor: theme.light,
          borderRadius: size / 2,
          shadowSize: 2,
          blurRadius: 5,
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: ClayText.body(
                '+$remaining',
                color: theme.onPrimary,
                fontSize: size * 0.30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
