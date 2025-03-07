// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;

enum DeviceSize {
  mobile,
  tablet,
  desktop,
}

abstract class FlutterFlowTheme {
  static DeviceSize deviceSize = DeviceSize.mobile;

  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static FlutterFlowTheme of(BuildContext context) {
    deviceSize = getDeviceSize(context);
    return Theme.of(context).brightness == Brightness.dark
        ? DarkModeTheme()
        : LightModeTheme();
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

  late Color customColor1;
  late Color customColor2;

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => {
        DeviceSize.mobile: MobileTypography(this),
        DeviceSize.tablet: TabletTypography(this),
        DeviceSize.desktop: DesktopTypography(this),
      }[deviceSize]!;
}

DeviceSize getDeviceSize(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  if (width < 479) {
    return DeviceSize.mobile;
  } else if (width < 991) {
    return DeviceSize.tablet;
  } else {
    return DeviceSize.desktop;
  }
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF1E3A8A);
  late Color secondary = const Color(0xFF0EA5E9);
  late Color tertiary = const Color(0xFF14B8A6);
  late Color alternate = const Color(0xFFA7F3D0);
  late Color primaryText = const Color(0xFF111827);
  late Color secondaryText = const Color(0xFF6B7280);
  late Color primaryBackground = const Color(0xFFF3F4F6);
  late Color secondaryBackground = const Color(0xFFE5E7EB);
  late Color accent1 = const Color(0xFF8B5CF6);
  late Color accent2 = const Color(0xFFD946EF);
  late Color accent3 = const Color(0xFFF97316);
  late Color accent4 = const Color(0xFF64748B);
  late Color success = const Color(0xFF4CAF50);
  late Color warning = const Color(0xFFFF9800);
  late Color error = const Color(0xFFF44336);
  late Color info = const Color(0xFFFFFFFF);

  late Color customColor1 = const Color(0xFFFFFFFF);
  late Color customColor2 = const Color(0xFF1E3A8A);
}

abstract class Typography {
  String get displayLargeFamily;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  TextStyle get bodySmall;
}

class MobileTypography extends Typography {
  MobileTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Lato';
  TextStyle get displayLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 60.0,
      );
  String get displayMediumFamily => 'Lato';
  TextStyle get displayMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 45.0,
      );
  String get displaySmallFamily => 'Lato';
  TextStyle get displaySmall => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 32.0,
      );
  String get headlineLargeFamily => 'Lato';
  TextStyle get headlineLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 32.0,
      );
  String get headlineMediumFamily => 'Lato';
  TextStyle get headlineMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  String get headlineSmallFamily => 'Lato';
  TextStyle get headlineSmall => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
      );
  String get titleLargeFamily => 'Lato';
  TextStyle get titleLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  String get titleMediumFamily => 'Lato';
  TextStyle get titleMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
      );
  String get titleSmallFamily => 'Lato';
  TextStyle get titleSmall => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get labelLargeFamily => 'Lato';
  TextStyle get labelLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get labelMediumFamily => 'Lato';
  TextStyle get labelMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );
  String get labelSmallFamily => 'Lato';
  TextStyle get labelSmall => GoogleFonts.getFont(
        'Lato',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      );
  String get bodyLargeFamily => 'Lato';
  TextStyle get bodyLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontSize: 16.0,
      );
  String get bodyMediumFamily => 'Lato';
  TextStyle get bodyMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  String get bodySmallFamily => 'Lato';
  TextStyle get bodySmall => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
}

class TabletTypography extends Typography {
  TabletTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Lato';
  TextStyle get displayLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 60.0,
      );
  String get displayMediumFamily => 'Lato';
  TextStyle get displayMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 45.0,
      );
  String get displaySmallFamily => 'Lato';
  TextStyle get displaySmall => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 32.0,
      );
  String get headlineLargeFamily => 'Lato';
  TextStyle get headlineLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 32.0,
      );
  String get headlineMediumFamily => 'Lato';
  TextStyle get headlineMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  String get headlineSmallFamily => 'Lato';
  TextStyle get headlineSmall => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
      );
  String get titleLargeFamily => 'Lato';
  TextStyle get titleLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  String get titleMediumFamily => 'Lato';
  TextStyle get titleMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.primary,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
      );
  String get titleSmallFamily => 'Lato';
  TextStyle get titleSmall => GoogleFonts.getFont(
        'Lato',
        color: theme.primary,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get labelLargeFamily => 'Lato';
  TextStyle get labelLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get labelMediumFamily => 'Lato';
  TextStyle get labelMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );
  String get labelSmallFamily => 'Lato';
  TextStyle get labelSmall => GoogleFonts.getFont(
        'Lato',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      );
  String get bodyLargeFamily => 'Lato';
  TextStyle get bodyLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontSize: 16.0,
      );
  String get bodyMediumFamily => 'Lato';
  TextStyle get bodyMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  String get bodySmallFamily => 'Lato';
  TextStyle get bodySmall => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
}

class DesktopTypography extends Typography {
  DesktopTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Lato';
  TextStyle get displayLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 60.0,
      );
  String get displayMediumFamily => 'Lato';
  TextStyle get displayMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 45.0,
      );
  String get displaySmallFamily => 'Lato';
  TextStyle get displaySmall => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 32.0,
      );
  String get headlineLargeFamily => 'Lato';
  TextStyle get headlineLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 32.0,
      );
  String get headlineMediumFamily => 'Lato';
  TextStyle get headlineMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  String get headlineSmallFamily => 'Lato';
  TextStyle get headlineSmall => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
      );
  String get titleLargeFamily => 'Lato';
  TextStyle get titleLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  String get titleMediumFamily => 'Lato';
  TextStyle get titleMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.primary,
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
      );
  String get titleSmallFamily => 'Lato';
  TextStyle get titleSmall => GoogleFonts.getFont(
        'Lato',
        color: theme.primary,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get labelLargeFamily => 'Lato';
  TextStyle get labelLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
      );
  String get labelMediumFamily => 'Lato';
  TextStyle get labelMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );
  String get labelSmallFamily => 'Lato';
  TextStyle get labelSmall => GoogleFonts.getFont(
        'Lato',
        color: theme.secondaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      );
  String get bodyLargeFamily => 'Lato';
  TextStyle get bodyLarge => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontSize: 16.0,
      );
  String get bodyMediumFamily => 'Lato';
  TextStyle get bodyMedium => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
      );
  String get bodySmallFamily => 'Lato';
  TextStyle get bodySmall => GoogleFonts.getFont(
        'Lato',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 12.0,
      );
}

class DarkModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF1E40AF);
  late Color secondary = const Color(0xFF3B82F6);
  late Color tertiary = const Color(0xFF38BDF8);
  late Color alternate = const Color(0xFF065F46);
  late Color primaryText = const Color(0xFFF9FAFB);
  late Color secondaryText = const Color(0xFF9CA3AF);
  late Color primaryBackground = const Color(0xFF1F2937);
  late Color secondaryBackground = const Color(0xFF111827);
  late Color accent1 = const Color(0xFFA855F7);
  late Color accent2 = const Color(0xFFEC4899);
  late Color accent3 = const Color(0xFFF59E0B);
  late Color accent4 = const Color(0xFF334155);
  late Color success = const Color(0xFF10B981);
  late Color warning = const Color(0xFFFBBF24);
  late Color error = const Color(0xFFEF4444);
  late Color info = const Color(0xFF60A5FA);

  late Color customColor1 = const Color(0xFFFFFFFF);
  late Color customColor2 = const Color(0xFFFFFFFF);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
    List<Shadow>? shadows,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
              shadows: shadows,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
              shadows: shadows,
            );
}
