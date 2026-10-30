import 'package:flutter/material.dart';

import '../../button/scripts/button.dart';
import '../../../palette/types/colors.dart';

class ClayImageViewer extends StatelessWidget {
  final ImageProvider? image;
  final Widget? child;
  final AlignmentGeometry alignment;
  final Color? color;
  final BlendMode? colorBlendMode;
  final String? heroTag;
  final bool showCloseButton;

  const ClayImageViewer({
    super.key,
    this.image,
    this.child,
    this.alignment = Alignment.center,
    this.color,
    this.colorBlendMode,
    this.heroTag,
    this.showCloseButton = true,
  }) : assert(image != null || child != null);

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = (constraints.maxWidth - 32)
              .clamp(1.0, double.infinity)
              .toDouble();
          final maxHeight = (constraints.maxHeight - 48)
              .clamp(1.0, double.infinity)
              .toDouble();

          Widget content =
              child ??
              Image(
                image: image!,
                width: maxWidth,
                height: maxHeight,
                fit: BoxFit.contain,
                alignment: alignment,
                color: color,
                colorBlendMode: colorBlendMode,
                filterQuality: FilterQuality.medium,
              );

          if (image != null && heroTag != null) {
            content = Hero(tag: heroTag!, child: content);
          }

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).maybePop(),
            child: Stack(
              alignment: Alignment.center,

              children: [
                Positioned.fill(
                  child: ColoredBox(
                    color: ClayColors.slate.s950.withValues(alpha: .70),
                  ),
                ),

                Center(
                  child: SizedBox(
                    width: maxWidth,
                    height: maxHeight,
                    child: InteractiveViewer(
                      constrained: true,
                      panEnabled: true,
                      scaleEnabled: true,
                      minScale: 1,
                      maxScale: 4,
                      boundaryMargin: const EdgeInsets.all(24),
                      clipBehavior: Clip.hardEdge,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: content,
                      ),
                    ),
                  ),
                ),

                if (showCloseButton)
                  Positioned(
                    top: MediaQuery.paddingOf(context).top + 12,
                    right: 16,
                    child: ClayButton.icon(
                      const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.of(context).maybePop(),
                      backgroundColor: ClayColors.ocean.s50,
                      iconColor: ClayColors.slate.s950,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
