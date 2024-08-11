import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);



  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff1a6b51),
      surfaceTint: Color(0xff1a6b51),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffa6f2d2),
      onPrimaryContainer: Color(0xff002116),
      secondary: Color(0xff4c6359),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcee9db),
      onSecondaryContainer: Color(0xff092017),
      tertiary: Color(0xff3f6375),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffc2e8fd),
      onTertiaryContainer: Color(0xff001f2a),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      background: Color(0xfff5fbf5),
      onBackground: Color(0xff171d1a),
      surface: Color(0xfff5fbf5),
      onSurface: Color(0xff171d1a),
      surfaceVariant: Color(0xffdbe5de),
      onSurfaceVariant: Color(0xff404944),
      outline: Color(0xff707974),
      outlineVariant: Color(0xffbfc9c2),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c322e),
      inverseOnSurface: Color(0xffecf2ed),
      inversePrimary: Color(0xff8ad6b7),
      primaryFixed: Color(0xffa6f2d2),
      onPrimaryFixed: Color(0xff002116),
      primaryFixedDim: Color(0xff8ad6b7),
      onPrimaryFixedVariant: Color(0xff00513c),
      secondaryFixed: Color(0xffcee9db),
      onSecondaryFixed: Color(0xff092017),
      secondaryFixedDim: Color(0xffb3ccbf),
      onSecondaryFixedVariant: Color(0xff354c42),
      tertiaryFixed: Color(0xffc2e8fd),
      onTertiaryFixed: Color(0xff001f2a),
      tertiaryFixedDim: Color(0xffa6cce0),
      onTertiaryFixedVariant: Color(0xff264b5c),
      surfaceDim: Color(0xffd6dbd6),
      surfaceBright: Color(0xfff5fbf5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f0),
      surfaceContainer: Color(0xffe9efea),
      surfaceContainerHigh: Color(0xffe4eae4),
      surfaceContainerHighest: Color(0xffdee4df),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff004d38),
      surfaceTint: Color(0xff1a6b51),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff368267),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff31483e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff627a6e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff214758),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff55798c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff5fbf5),
      onBackground: Color(0xff171d1a),
      surface: Color(0xfff5fbf5),
      onSurface: Color(0xff171d1a),
      surfaceVariant: Color(0xffdbe5de),
      onSurfaceVariant: Color(0xff3c4540),
      outline: Color(0xff58615c),
      outlineVariant: Color(0xff737d77),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c322e),
      inverseOnSurface: Color(0xffecf2ed),
      inversePrimary: Color(0xff8ad6b7),
      primaryFixed: Color(0xff368267),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff16684f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff627a6e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4a6156),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff55798c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff3c6172),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd6dbd6),
      surfaceBright: Color(0xfff5fbf5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f0),
      surfaceContainer: Color(0xffe9efea),
      surfaceContainerHigh: Color(0xffe4eae4),
      surfaceContainerHighest: Color(0xffdee4df),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(0xff00281c),
      surfaceTint: Color(0xff1a6b51),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004d38),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff10261e),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff31483e),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002633),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff214758),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      background: Color(0xfff5fbf5),
      onBackground: Color(0xff171d1a),
      surface: Color(0xfff5fbf5),
      onSurface: Color(0xff000000),
      surfaceVariant: Color(0xffdbe5de),
      onSurfaceVariant: Color(0xff1d2622),
      outline: Color(0xff3c4540),
      outlineVariant: Color(0xff3c4540),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c322e),
      inverseOnSurface: Color(0xffffffff),
      inversePrimary: Color(0xffaffcdb),
      primaryFixed: Color(0xff004d38),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003425),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff31483e),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1b3128),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff214758),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff043141),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd6dbd6),
      surfaceBright: Color(0xfff5fbf5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f0),
      surfaceContainer: Color(0xffe9efea),
      surfaceContainerHigh: Color(0xffe4eae4),
      surfaceContainerHighest: Color(0xffdee4df),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8ad6b7),
      surfaceTint: Color(0xff8ad6b7),
      onPrimary: Color(0xff003828),
      primaryContainer: Color(0xff00513c),
      onPrimaryContainer: Color(0xffa6f2d2),
      secondary: Color(0xffb3ccbf),
      onSecondary: Color(0xff1e352c),
      secondaryContainer: Color(0xff354c42),
      onSecondaryContainer: Color(0xffcee9db),
      tertiary: Color(0xffa6cce0),
      onTertiary: Color(0xff0a3545),
      tertiaryContainer: Color(0xff264b5c),
      onTertiaryContainer: Color(0xffc2e8fd),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      background: Color(0xff0f1512),
      onBackground: Color(0xffdee4df),
      surface: Color(0xff0f1512),
      onSurface: Color(0xffdee4df),
      surfaceVariant: Color(0xff404944),
      onSurfaceVariant: Color(0xffbfc9c2),
      outline: Color(0xff89938d),
      outlineVariant: Color(0xff404944),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4df),
      inverseOnSurface: Color(0xff2c322e),
      inversePrimary: Color(0xff1a6b51),
      primaryFixed: Color(0xffa6f2d2),
      onPrimaryFixed: Color(0xff002116),
      primaryFixedDim: Color(0xff8ad6b7),
      onPrimaryFixedVariant: Color(0xff00513c),
      secondaryFixed: Color(0xffcee9db),
      onSecondaryFixed: Color(0xff092017),
      secondaryFixedDim: Color(0xffb3ccbf),
      onSecondaryFixedVariant: Color(0xff354c42),
      tertiaryFixed: Color(0xffc2e8fd),
      onTertiaryFixed: Color(0xff001f2a),
      tertiaryFixedDim: Color(0xffa6cce0),
      onTertiaryFixedVariant: Color(0xff264b5c),
      surfaceDim: Color(0xff0f1512),
      surfaceBright: Color(0xff343b37),
      surfaceContainerLowest: Color(0xff0a0f0d),
      surfaceContainerLow: Color(0xff171d1a),
      surfaceContainer: Color(0xff1b211e),
      surfaceContainerHigh: Color(0xff252b28),
      surfaceContainerHighest: Color(0xff303633),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8edabb),
      surfaceTint: Color(0xff8ad6b7),
      onPrimary: Color(0xff001b12),
      primaryContainer: Color(0xff549e82),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb7d1c3),
      onSecondary: Color(0xff041a12),
      secondaryContainer: Color(0xff7e968a),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffabd0e4),
      onTertiary: Color(0xff001923),
      tertiaryContainer: Color(0xff7196a9),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0f1512),
      onBackground: Color(0xffdee4df),
      surface: Color(0xff0f1512),
      onSurface: Color(0xfff6fcf7),
      surfaceVariant: Color(0xff404944),
      onSurfaceVariant: Color(0xffc3cdc6),
      outline: Color(0xff9ba59f),
      outlineVariant: Color(0xff7c8580),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4df),
      inverseOnSurface: Color(0xff252b28),
      inversePrimary: Color(0xff00533d),
      primaryFixed: Color(0xffa6f2d2),
      onPrimaryFixed: Color(0xff00150d),
      primaryFixedDim: Color(0xff8ad6b7),
      onPrimaryFixedVariant: Color(0xff003f2d),
      secondaryFixed: Color(0xffcee9db),
      onSecondaryFixed: Color(0xff01150d),
      secondaryFixedDim: Color(0xffb3ccbf),
      onSecondaryFixedVariant: Color(0xff243b31),
      tertiaryFixed: Color(0xffc2e8fd),
      onTertiaryFixed: Color(0xff00131c),
      tertiaryFixedDim: Color(0xffa6cce0),
      onTertiaryFixedVariant: Color(0xff123a4b),
      surfaceDim: Color(0xff0f1512),
      surfaceBright: Color(0xff343b37),
      surfaceContainerLowest: Color(0xff0a0f0d),
      surfaceContainerLow: Color(0xff171d1a),
      surfaceContainer: Color(0xff1b211e),
      surfaceContainerHigh: Color(0xff252b28),
      surfaceContainerHighest: Color(0xff303633),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(0xffedfff4),
      surfaceTint: Color(0xff8ad6b7),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff8edabb),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffedfff4),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb7d1c3),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff7fbff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffabd0e4),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      background: Color(0xff0f1512),
      onBackground: Color(0xffdee4df),
      surface: Color(0xff0f1512),
      onSurface: Color(0xffffffff),
      surfaceVariant: Color(0xff404944),
      onSurfaceVariant: Color(0xfff3fdf6),
      outline: Color(0xffc3cdc6),
      outlineVariant: Color(0xffc3cdc6),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee4df),
      inverseOnSurface: Color(0xff000000),
      inversePrimary: Color(0xff003123),
      primaryFixed: Color(0xffaaf7d6),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff8edabb),
      onPrimaryFixedVariant: Color(0xff001b12),
      secondaryFixed: Color(0xffd3eddf),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb7d1c3),
      onSecondaryFixedVariant: Color(0xff041a12),
      tertiaryFixed: Color(0xffcaecff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffabd0e4),
      onTertiaryFixedVariant: Color(0xff001923),
      surfaceDim: Color(0xff0f1512),
      surfaceBright: Color(0xff343b37),
      surfaceContainerLowest: Color(0xff0a0f0d),
      surfaceContainerLow: Color(0xff171d1a),
      surfaceContainer: Color(0xff1b211e),
      surfaceContainerHigh: Color(0xff252b28),
      surfaceContainerHighest: Color(0xff303633),
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
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );

  /// Custom Color
  static const customColor = ExtendedColor(
    seed: Color(0xff3f7ec7),
    value: Color(0xff3f7ec7),
    light: ColorFamily(
      color: Color(0xff3a608f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffd3e3ff),
      onColorContainer: Color(0xff001c39),
    ),
    lightMediumContrast: ColorFamily(
      color: Color(0xff3a608f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffd3e3ff),
      onColorContainer: Color(0xff001c39),
    ),
    lightHighContrast: ColorFamily(
      color: Color(0xff3a608f),
      onColor: Color(0xffffffff),
      colorContainer: Color(0xffd3e3ff),
      onColorContainer: Color(0xff001c39),
    ),
    dark: ColorFamily(
      color: Color(0xffa4c9fe),
      onColor: Color(0xff00315d),
      colorContainer: Color(0xff204876),
      onColorContainer: Color(0xffd3e3ff),
    ),
    darkMediumContrast: ColorFamily(
      color: Color(0xffa4c9fe),
      onColor: Color(0xff00315d),
      colorContainer: Color(0xff204876),
      onColorContainer: Color(0xffd3e3ff),
    ),
    darkHighContrast: ColorFamily(
      color: Color(0xffa4c9fe),
      onColor: Color(0xff00315d),
      colorContainer: Color(0xff204876),
      onColorContainer: Color(0xffd3e3ff),
    ),
  );


  List<ExtendedColor> get extendedColors => [
    customColor,
  ];
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
      surface: surface,
      onSurface: onSurface,
      surfaceContainerHighest: surfaceVariant,
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
