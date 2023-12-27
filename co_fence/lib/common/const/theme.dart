import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff005484),
      surfaceTint: Color(0xff00639a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff007abd),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff44617c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffc7e2ff),
      onSecondaryContainer: Color.fromARGB(255, 159, 168, 176),
      tertiary: Color(0xff002f3e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1a5267),
      onTertiaryContainer: Color(0xffcfefff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff7f9ff),
      onBackground: Color(0xff181c20),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff181c20),
      surfaceVariant: Color(0xffdbe3ee),
      onSurfaceVariant: Color(0xff404850),
      outline: Color(0xff707881),
      outlineVariant: Color(0xffbfc7d2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inverseOnSurface: Color(0xffeef1f7),
      inversePrimary: Color(0xff96ccff),
      primaryFixed: Color(0xffcee5ff),
      onPrimaryFixed: Color(0xff001d32),
      primaryFixedDim: Color(0xff96ccff),
      onPrimaryFixedVariant: Color(0xff004a75),
      secondaryFixed: Color(0xffcee5ff),
      onSecondaryFixed: Color(0xff001d32),
      secondaryFixedDim: Color(0xffaccae9),
      onSecondaryFixedVariant: Color(0xff2c4963),
      tertiaryFixed: Color(0xffbde9ff),
      onTertiaryFixed: Color(0xff001f2a),
      tertiaryFixedDim: Color(0xff9bcee6),
      onTertiaryFixedVariant: Color(0xff124d61),
      surfaceDim: Color(0xffd7dae0),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4fa),
      surfaceContainer: Color(0xffebeef4),
      surfaceContainerHigh: Color(0xffe5e8ee),
      surfaceContainerHighest: Color(0xffe0e2e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00466f),
      surfaceTint: Color(0xff00639a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff007abd),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff28455f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5a7794),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002f3e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff1a5267),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff7f9ff),
      onBackground: Color(0xff181c20),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff181c20),
      surfaceVariant: Color(0xffdbe3ee),
      onSurfaceVariant: Color(0xff3c444c),
      outline: Color(0xff586069),
      outlineVariant: Color(0xff747b85),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inverseOnSurface: Color(0xffeef1f7),
      inversePrimary: Color(0xff96ccff),
      primaryFixed: Color(0xff007abd),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff006096),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5a7794),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff425f7a),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff487b91),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff2d6277),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd7dae0),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4fa),
      surfaceContainer: Color(0xffebeef4),
      surfaceContainerHigh: Color(0xffe5e8ee),
      surfaceContainerHighest: Color(0xffe0e2e9),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00243d),
      surfaceTint: Color(0xff00639a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00466f),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff00243d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff28455f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002633),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff0b495d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff7f9ff),
      onBackground: Color(0xff181c20),
      surface: Color(0xfff7f9ff),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdbe3ee),
      onSurfaceVariant: Color(0xff1d252d),
      outline: Color(0xff3c444c),
      outlineVariant: Color(0xff3c444c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3135),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffdfedff),
      primaryFixed: Color(0xff00466f),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff002f4d),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff28455f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff0e2f48),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff0b495d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff003141),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd7dae0),
      surfaceBright: Color(0xfff7f9ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4fa),
      surfaceContainer: Color(0xffebeef4),
      surfaceContainerHigh: Color(0xffe5e8ee),
      surfaceContainerHighest: Color(0xffe0e2e9),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff96ccff),
      surfaceTint: Color(0xff96ccff),
      onPrimary: Color(0xff003353),
      primaryContainer: Color(0xff0073b2),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xffaccae9),
      onSecondary: Color(0xff13334c),
      secondaryContainer: Color(0xff24425c),
      onSecondaryContainer: Color(0xffbad8f8),
      tertiary: Color(0xff9bcee6),
      onTertiary: Color(0xff003546),
      tertiaryContainer: Color(0xff00384a),
      onTertiaryContainer: Color(0xff97cae2),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff101418),
      onBackground: Color(0xffe0e2e9),
      surface: Color(0xff101418),
      onSurface: Color(0xffe0e2e9),
      surfaceVariant: Color(0xff404850),
      onSurfaceVariant: Color(0xffbfc7d2),
      outline: Color(0xff8a919b),
      outlineVariant: Color(0xff404850),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e9),
      inverseOnSurface: Color(0xff2d3135),
      inversePrimary: Color(0xff00639a),
      primaryFixed: Color(0xffcee5ff),
      onPrimaryFixed: Color(0xff001d32),
      primaryFixedDim: Color(0xff96ccff),
      onPrimaryFixedVariant: Color(0xff004a75),
      secondaryFixed: Color(0xffcee5ff),
      onSecondaryFixed: Color(0xff001d32),
      secondaryFixedDim: Color(0xffaccae9),
      onSecondaryFixedVariant: Color(0xff2c4963),
      tertiaryFixed: Color(0xffbde9ff),
      onTertiaryFixed: Color(0xff001f2a),
      tertiaryFixedDim: Color(0xff9bcee6),
      onTertiaryFixedVariant: Color(0xff124d61),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff36393e),
      surfaceContainerLowest: Color(0xff0b0f13),
      surfaceContainerLow: Color(0xff181c20),
      surfaceContainer: Color(0xff1c2024),
      surfaceContainerHigh: Color(0xff262a2f),
      surfaceContainerHighest: Color(0xff31353a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9fcfff),
      surfaceTint: Color(0xff96ccff),
      onPrimary: Color(0xff00182a),
      primaryContainer: Color(0xff3897dc),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb0ceed),
      onSecondary: Color(0xff00182a),
      secondaryContainer: Color(0xff7694b1),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xff9fd2ea),
      onTertiary: Color(0xff001923),
      tertiaryContainer: Color(0xff6597ae),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff101418),
      onBackground: Color(0xffe0e2e9),
      surface: Color(0xff101418),
      onSurface: Color(0xfffafaff),
      surfaceVariant: Color(0xff404850),
      onSurfaceVariant: Color(0xffc4cbd6),
      outline: Color(0xff9ca4ae),
      outlineVariant: Color(0xff7c848e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e9),
      inverseOnSurface: Color(0xff262a2f),
      inversePrimary: Color(0xff004c77),
      primaryFixed: Color(0xffcee5ff),
      onPrimaryFixed: Color(0xff001222),
      primaryFixedDim: Color(0xff96ccff),
      onPrimaryFixedVariant: Color(0xff00395c),
      secondaryFixed: Color(0xffcee5ff),
      onSecondaryFixed: Color(0xff001222),
      secondaryFixedDim: Color(0xffaccae9),
      onSecondaryFixedVariant: Color(0xff1a3852),
      tertiaryFixed: Color(0xffbde9ff),
      onTertiaryFixed: Color(0xff00131c),
      tertiaryFixedDim: Color(0xff9bcee6),
      onTertiaryFixedVariant: Color(0xff003b4d),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff36393e),
      surfaceContainerLowest: Color(0xff0b0f13),
      surfaceContainerLow: Color(0xff181c20),
      surfaceContainer: Color(0xff1c2024),
      surfaceContainerHigh: Color(0xff262a2f),
      surfaceContainerHighest: Color(0xff31353a),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffafaff),
      surfaceTint: Color(0xff96ccff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff9fcfff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffafaff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb0ceed),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff7fbff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff9fd2ea),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff101418),
      onBackground: Color(0xffe0e2e9),
      surface: Color(0xff101418),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff404850),
      onSurfaceVariant: Color(0xfffafaff),
      outline: Color(0xffc4cbd6),
      outlineVariant: Color(0xffc4cbd6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e2e9),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff002c49),
      primaryFixed: Color(0xffd6e9ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff9fcfff),
      onPrimaryFixedVariant: Color(0xff00182a),
      secondaryFixed: Color(0xffd6e9ff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb0ceed),
      onSecondaryFixedVariant: Color(0xff00182a),
      tertiaryFixed: Color(0xffc8ecff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff9fd2ea),
      onTertiaryFixedVariant: Color(0xff001923),
      surfaceDim: Color(0xff101418),
      surfaceBright: Color(0xff36393e),
      surfaceContainerLowest: Color(0xff0b0f13),
      surfaceContainerLow: Color(0xff181c20),
      surfaceContainer: Color(0xff1c2024),
      surfaceContainerHigh: Color(0xff262a2f),
      surfaceContainerHighest: Color(0xff31353a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
