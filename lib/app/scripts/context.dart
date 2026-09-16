import 'package:flutter/material.dart';

import '../../palette/types/palette.dart';
import '../../theme/scripts/theme.dart';
import '../../theme/scripts/data.dart';

extension ClayContext on BuildContext {
  ClayThemeData get clayTheme => ClayTheme.of(this);

  ClayPalette get clayPalette => clayTheme.seedColor;
}
