// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) {
    return LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color primaryContainer;
  late Color secondaryContainer;
  late Color onPrimary;
  late Color onSecondary;
  late Color onTertiary;
  late Color onError;
  late Color onBackground;
  late Color onSurface;
  late Color surfaceVariant;

  late Color primary5;
  late Color secondary20;
  late Color onPrimary80;
  late Color surfaceVariant30;
  late Color surface80;
  late Color onPrimaryContainer;
  late Color onSuccess;

  String get title1Family => 'Plus Jakarta Sans';
  TextStyle get title1 => GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      );
  String get title2Family => 'Plus Jakarta Sans';
  TextStyle get title2 => GoogleFonts.plusJakartaSans(
        fontSize: 28,
        fontWeight: FontWeight.w600,
      );
  String get title3Family => 'Plus Jakarta Sans';
  TextStyle get title3 => GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      );
  String get subtitle1Family => 'Inter';
  TextStyle get subtitle1 => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      );
  String get subtitle2Family => 'Inter';
  TextStyle get subtitle2 => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );
  String get bodyText1Family => 'Inter';
  TextStyle get bodyText1 => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
  String get bodyText2Family => 'Inter';
  TextStyle get bodyText2 => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      );

  TextStyle get displayLarge => GoogleFonts.plusJakartaSans(
        fontSize: 57,
        fontWeight: FontWeight.w400,
      );
  TextStyle get displayMedium => GoogleFonts.plusJakartaSans(
        fontSize: 45,
        fontWeight: FontWeight.w400,
      );
  TextStyle get displaySmall => GoogleFonts.plusJakartaSans(
        fontSize: 36,
        fontWeight: FontWeight.w400,
      );
  TextStyle get headlineLarge => GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      );
  TextStyle get headlineMedium => GoogleFonts.plusJakartaSans(
        fontSize: 28,
        fontWeight: FontWeight.w600,
      );
  TextStyle get headlineSmall => GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      );
  TextStyle get titleLarge => GoogleFonts.plusJakartaSans(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      );
  TextStyle get titleMedium => GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      );
  TextStyle get titleSmall => GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );
  TextStyle get labelLarge => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );
  TextStyle get labelMedium => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );
  TextStyle get labelSmall => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
      );
  TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );
  TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      );
  TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      );
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF0D9488);
  late Color secondary = const Color(0xFF64748B);
  late Color tertiary = const Color(0xFF14B8A6);
  late Color alternate = const Color(0xFFE2E8F0);
  late Color primaryText = const Color(0xFF0F172A);
  late Color secondaryText = const Color(0xFF64748B);
  late Color primaryBackground = const Color(0xFFF8FAFC);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color accent1 = const Color(0x4D0D9488);
  late Color accent2 = const Color(0x4D64748B);
  late Color accent3 = const Color(0x4D14B8A6);
  late Color accent4 = const Color(0xCCFFFFFF);
  late Color success = const Color(0xFF22C55E);
  late Color warning = const Color(0xFFF59E0B);
  late Color error = const Color(0xFFEF4444);
  late Color info = const Color(0xFF3B82F6);

  late Color primaryContainer = const Color(0xFFCCFBF1);
  late Color secondaryContainer = const Color(0xFFF1F5F9);
  late Color onPrimary = const Color(0xFFFFFFFF);
  late Color onSecondary = const Color(0xFFFFFFFF);
  late Color onTertiary = const Color(0xFFFFFFFF);
  late Color onError = const Color(0xFFFFFFFF);
  late Color onBackground = const Color(0xFF0F172A);
  late Color onSurface = const Color(0xFF0F172A);
  late Color surfaceVariant = const Color(0xFFF1F5F9);

  late Color primary5 = const Color(0x0D0D9488);
  late Color secondary20 = const Color(0x3364748B);
  late Color onPrimary80 = const Color(0xCCFFFFFF);
  late Color surfaceVariant30 = const Color(0x4DF1F5F9);
  late Color surface80 = const Color(0xCCF1F5F9);
  late Color onPrimaryContainer = const Color(0xFF0F766E);
  late Color onSuccess = const Color(0xFFFFFFFF);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    TextStyle? font,
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? lineHeight,
    List<Shadow>? shadows,
    TextDecoration? decoration,
  }) {
    return copyWith(
      fontFamily: fontFamily ?? font?.fontFamily ?? this.fontFamily,
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? font?.fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? font?.fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      height: lineHeight ?? height,
      shadows: shadows ?? this.shadows,
      decoration: decoration ?? this.decoration,
    );
  }
}
