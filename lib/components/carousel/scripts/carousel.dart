import 'dart:async';

import 'package:flutter/material.dart';

import '../../button/scripts/button.dart';
import '../../text/scripts/text.dart';

class ClayCarousel extends StatefulWidget {
  const ClayCarousel({
    super.key,
    required this.items,
    this.initialPage = 0,
    this.height = 320,
    this.aspectRatio,
    this.showArrows = true,
    this.showDots = true,
    this.showProgress = false,
    this.infinite = true,
    this.autoplay = false,
    this.autoplayInterval = const Duration(seconds: 4),
    this.animationDuration = const Duration(milliseconds: 420),
    this.viewportFraction = 1,
    this.spacing = 0,
    this.padding = EdgeInsets.zero,
    this.borderRadius = 24,
    this.arrowSize = 42,
    this.arrowInset = 12,
    this.indicatorAlignment = Alignment.bottomCenter,
    this.indicatorPadding = const EdgeInsets.only(bottom: 14),
    this.onPageChanged,
    this.onItemTap,
    this.clipBehavior = Clip.antiAlias,
  }) : assert(items.length > 0, 'The carousel needs at least one item.'),
       assert(viewportFraction > 0 && viewportFraction <= 1),
       assert(spacing >= 0),
       assert(height > 0),
       assert(borderRadius >= 0),
       assert(arrowSize > 0);

  final List<ClayCarouselItem> items;

  final int initialPage;
  final double height;
  final double? aspectRatio;

  final bool showArrows;
  final bool showDots;
  final bool showProgress;
  final bool infinite;
  final bool autoplay;

  final Duration autoplayInterval;
  final Duration animationDuration;

  final double viewportFraction;
  final double spacing;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double arrowSize;
  final double arrowInset;

  final Alignment indicatorAlignment;
  final EdgeInsetsGeometry indicatorPadding;

  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int>? onItemTap;

  final Clip clipBehavior;

  @override
  State<ClayCarousel> createState() => _ClayCarouselState();
}

class _ClayCarouselState extends State<ClayCarousel> {
  late PageController _pageController;
  late int _currentPage;

  Timer? _autoplayTimer;
  bool _isAnimating = false;

  int get _count => widget.items.length;

  int get _realIndex => _currentPage % _count;

  @override
  void initState() {
    super.initState();

    _currentPage = widget.initialPage.clamp(0, _count - 1);
    _createPageController();
    _configureAutoplay();
  }

  void _createPageController() {
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: widget.viewportFraction,
    );
  }

  void _configureAutoplay() {
    _autoplayTimer?.cancel();

    if (!widget.autoplay || _count < 2) return;

    _autoplayTimer = Timer.periodic(widget.autoplayInterval, (_) {
      if (!mounted || !_pageController.hasClients || _isAnimating) {
        return;
      }

      _goToPage(_currentPage + 1);
    });
  }

  @override
  void didUpdateWidget(covariant ClayCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.autoplay != widget.autoplay ||
        oldWidget.autoplayInterval != widget.autoplayInterval ||
        oldWidget.items.length != widget.items.length) {
      _configureAutoplay();
    }

    if (oldWidget.viewportFraction != widget.viewportFraction) {
      final previousController = _pageController;

      _createPageController();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        previousController.dispose();

        if (!mounted || !_pageController.hasClients) return;

        _pageController.jumpToPage(_currentPage.clamp(0, _count - 1));
      });
    }

    if (_currentPage >= _count) {
      _currentPage = _count - 1;
    }
  }

  @override
  void dispose() {
    _autoplayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
      _isAnimating = false;
    });

    widget.onPageChanged?.call(_realIndex);
  }

  Future<void> _goToPage(int page) async {
    if (!_pageController.hasClients || _isAnimating) return;

    if (!widget.infinite) {
      page = page.clamp(0, _count - 1);
    }

    setState(() => _isAnimating = true);

    try {
      await _pageController.animateToPage(
        page,
        duration: widget.animationDuration,
        curve: Curves.easeOutCubic,
      );
    } finally {
      if (mounted) {
        setState(() => _isAnimating = false);
      }
    }
  }

  void _previous() {
    if (!widget.infinite && _realIndex == 0) return;
    _goToPage(_currentPage - 1);
  }

  void _next() {
    if (!widget.infinite && _realIndex == _count - 1) return;
    _goToPage(_currentPage + 1);
  }

  Widget _arrow({
    required Widget icon,
    required VoidCallback onPressed,
    required bool enabled,
    required bool isLeft,
  }) {
    return SizedBox(
      width: widget.arrowSize,
      height: widget.arrowSize,
      child: Material(
        color: Colors.black.withValues(alpha: enabled ? 0.38 : 0.15),
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          customBorder: const CircleBorder(),
          child: IconTheme(
            data: IconThemeData(
              color: Colors.white.withValues(alpha: enabled ? 1 : 0.35),
              size: 21,
            ),
            child: icon,
          ),
        ),
      ),
    );
  }

  Widget _indicators() {
    if (!widget.showDots && !widget.showProgress) {
      return const SizedBox.shrink();
    }

    if (_count < 2) return const SizedBox.shrink();

    if (widget.showProgress) {
      return Container(
        width: 76,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(99),
        ),
        clipBehavior: Clip.antiAlias,
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedFractionallySizedBox(
            duration: widget.animationDuration,
            curve: Curves.easeOutCubic,
            widthFactor: (_realIndex + 1) / _count,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_count, (index) {
        final selected = index == _realIndex;

        return GestureDetector(
          onTap: () {
            final target = widget.infinite
                ? _currentPage - _realIndex + index
                : index;

            _goToPage(target);
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: AnimatedContainer(
              duration: widget.animationDuration,
              curve: Curves.easeOutCubic,
              width: selected ? 22 : 7,
              height: 7,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: selected ? 1 : 0.5),
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final carousel = ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      clipBehavior: widget.clipBehavior,
      child: SizedBox(
        height: widget.aspectRatio == null ? widget.height : null,
        child: AspectRatio(
          aspectRatio: widget.aspectRatio ?? 1000 / widget.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: widget.infinite ? null : _count,
                clipBehavior: Clip.none,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  final item = widget.items[index % _count];

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.spacing / 2,
                    ),
                    child: item.build(
                      context,
                      onTap: () => widget.onItemTap?.call(index % _count),
                      borderRadius: widget.borderRadius,
                    ),
                  );
                },
              ),

              if (widget.showArrows && _count > 1) ...[
                Positioned(
                  left: widget.arrowInset,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _arrow(
                      icon: Icon(Icons.chevron_left_rounded),
                      onPressed: _previous,
                      enabled: widget.infinite || _realIndex > 0,
                      isLeft: true,
                    ),
                  ),
                ),
                Positioned(
                  right: widget.arrowInset,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _arrow(
                      icon: Icon(Icons.chevron_right_rounded),
                      onPressed: _next,
                      enabled: widget.infinite || _realIndex < _count - 1,
                      isLeft: false,
                    ),
                  ),
                ),
              ],

              if (widget.showDots || widget.showProgress)
                Positioned.fill(
                  child: Align(
                    alignment: widget.indicatorAlignment,
                    child: Padding(
                      padding: widget.indicatorPadding,
                      child: _indicators(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    return Padding(padding: widget.padding, child: carousel);
  }
}

class ClayCarouselItem {
  const ClayCarouselItem({
    this.image,
    this.background,
    this.tag,
    this.title,
    this.subtitle,
    this.description,
    this.gradient = true,
    this.gradientColors,
    this.contentAlignment = Alignment.bottomLeft,
    this.contentPadding = const EdgeInsets.fromLTRB(24, 24, 24, 38),
    this.buttons = const [],
    this.buttonSpacing = 10,
    this.contentSpacing = 8,
    this.onTap,
    this.borderRadius,
    this.imageFit = BoxFit.cover,
    this.overlayColor,
  }) : assert(
         image != null || background != null,
         'Provide an image or background for the slide.',
       );

  final ImageProvider? image;
  final Widget? background;

  final String? tag;
  final String? title;
  final String? subtitle;
  final String? description;

  final bool gradient;
  final List<Color>? gradientColors;
  final Color? overlayColor;

  final Alignment contentAlignment;
  final EdgeInsetsGeometry contentPadding;

  final List<ClayCarouselButton> buttons;
  final double buttonSpacing;
  final double contentSpacing;

  final VoidCallback? onTap;
  final double? borderRadius;
  final BoxFit imageFit;

  Widget build(
    BuildContext context, {
    VoidCallback? onTap,
    double? borderRadius,
  }) {
    final alignment = contentAlignment;
    final isBottom = alignment.y > 0.25;

    final colors =
        gradientColors ??
        [
          Colors.transparent,
          Colors.black.withValues(alpha: 0.18),
          Colors.black.withValues(alpha: 0.88),
        ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(
        this.borderRadius ?? borderRadius ?? 0,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (image != null)
            Image(
              image: image!,
              fit: imageFit,
              width: double.infinity,
              height: double.infinity,
              filterQuality: FilterQuality.medium,
            )
          else
            background!,

          if (overlayColor != null) ColoredBox(color: overlayColor!),

          if (gradient)
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: colors,
                  stops: colors.length == 3 ? const [0, 0.35, 1] : null,
                ),
              ),
            ),

          if (onTap != null || this.onTap != null)
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: this.onTap ?? onTap,
                  splashColor: Colors.white.withValues(alpha: 0.08),
                  highlightColor: Colors.transparent,
                ),
              ),
            ),

          Positioned.fill(
            child: Padding(
              padding: contentPadding,
              child: Align(
                alignment: alignment,
                child: _buildContent(context, isBottom: isBottom),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, {required bool isBottom}) {
    final children = <Widget>[];

    if (tag != null && tag!.isNotEmpty) {
      children.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(99),
            border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
          ),
          child: ClayText.label(
            tag!,
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
        ),
      );
    }

    if (subtitle != null && subtitle!.isNotEmpty) {
      children.add(
        ClayText.label(
          subtitle!,
          color: Colors.white.withValues(alpha: 0.85),
          fontSize: 13,
          fontWeight: FontWeight.w500,
          height: 1.35,
        ),
      );
    }

    if (title != null && title!.isNotEmpty) {
      children.add(
        ClayText.title(
          title!,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.w800,
          height: 1.08,
          letterSpacing: -0.7,
        ),
      );
    }

    if (description != null && description!.isNotEmpty) {
      children.add(
        ClayText.label(
          description!,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          color: Colors.white.withValues(alpha: 0.82),
          fontSize: 13,
          height: 1.45,
        ),
      );
    }

    if (buttons.isNotEmpty) {
      children.add(
        Wrap(
          spacing: buttonSpacing,
          runSpacing: buttonSpacing,
          children: buttons.map((button) => button.build()).toList(),
        ),
      );
    }

    if (children.isEmpty) return const SizedBox.shrink();

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 520),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) SizedBox(height: contentSpacing),
            children[i],
          ],
        ],
      ),
    );
  }
}

/// Botão configurável para os slides.
class ClayCarouselButton {
  const ClayCarouselButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.primary = false,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool primary;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;

  Widget build() {
    if (primary) {
      return ClayButton.primary(label, onPressed: onPressed, iconLeft: icon);
    }

    return ClayButton.tertiary(label, onPressed: onPressed, iconLeft: icon);
  }
}
