import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClayTextTypography {
  static TextStyle display({Color? color}) => GoogleFonts.crimsonText(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.5,
    color: color,
  );

  static TextStyle title({Color? color}) => GoogleFonts.crimsonText(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: color,
  );

  static TextStyle body({Color? color}) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    color: color,
  );

  static TextStyle label({Color? color}) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.2,
    color: color,
  );
}
