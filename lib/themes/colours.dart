import 'package:flutter/material.dart';

const PrimaryColour = const Color(0xFF11a7f2);
const PrimaryColourLight = const Color(0xFFf0fafe);
const PrimaryColourDark = const Color(0xFF3366cc);
const SecondaryColour = const Color(0xFFe00087);
const SecondaryColourLight = const Color(0xFFFFDEEA);
const Background = const Color(0xFFFFFFFF);
const TextColor = const Color(0xFF000000);

class whamTheme {
  static final ThemeData defaultTheme = _buildWHAMTheme();

  static ThemeData _buildWHAMTheme() {
    final theme = ThemeData.dark();

    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        primary: PrimaryColour,
        secondary: SecondaryColour,
        background: Background,
      ),
      iconTheme: theme.iconTheme.copyWith(color: Colors.white),
      buttonTheme: theme.buttonTheme.copyWith(
          buttonColor: SecondaryColour, textTheme: ButtonTextTheme.primary),
      scaffoldBackgroundColor: Background,
      backgroundColor: Background,
    );
  }
}
