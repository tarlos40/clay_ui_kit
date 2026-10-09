import 'package:flutter/material.dart';

import '../../../app/scripts/context.dart';
import '../../../components/texts/scripts/text.dart';
import '../../../utils/random_colors.dart';
import '../types/size.dart';
import '../../../theme/scripts/shadows.dart';

class ClayAvatar extends StatelessWidget {
  final String? name;
  final String? label;
  final IconData? icon;
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
  }) {
    return ClayAvatarGroup(
      overlap: overlap,
      alignment: alignment,
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

    final avatar = ClipOval(
      child: SizedBox(width: avatarSize, height: avatarSize, child: content),
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
    final theme = context.clayTheme;

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
          child: Icon(icon, size: size * 0.48, color: foreground),
        ),
      );
    }

    final text = label ?? (name != null ? _initials(name!) : '');

    return CustomPaint(
      foregroundPainter: ClayInnerShadowPainter(
        shadowColor: theme.shadow,
        lightColor: theme.light,
        borderRadius: 100,
        shadowSize: 2.5,
        blurRadius: 7.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(100),
          boxShadow: ClayShadows.external(theme: theme, offset: 1, blur: 3),
        ),
        child: Center(
          child: ClayText.label(
            text,
            color: foreground,
            fontWeight: FontWeight.w700,
          ),
        ),
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

  const ClayAvatarGroup({
    super.key,
    required this.children,
    this.overlap = 12,
    this.alignment = MainAxisAlignment.start,
  }) : assert(overlap >= 0, 'ClayAvatarGroup: overlap cannot be negative.');

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    if (children.length == 1) {
      return children.first;
    }

    final avatarSize = children.first.dimension;

    final itemWidth = avatarSize - overlap;

    final width = avatarSize + ((children.length - 1) * itemWidth);

    return SizedBox(
      width: width,
      height: avatarSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(children.length, (index) {
          return Positioned(
            left: index * itemWidth,
            top: 0,
            child: children[index],
          );
        }),
      ),
    );
  }
}
