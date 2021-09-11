import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0xff6b8e4e, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff608046), //10%
      100: const Color(0xff56723e), //20%
      200: const Color(0xff4b6337), //30%
      300: const Color(0xff40552f), //40%
      400: const Color(0xff364727), //50%
      500: const Color(0xff2b391f), //60%
      600: const Color(0xff202b17), //70%
      700: const Color(0xff151c10), //80%
      800: const Color(0xff0b0e08), //90%
      900: const Color(0xff0000009), //100%
    },
  );
} //

Color kPrimaryColor = Color(0xff6b8e4e);

Color kMentalColor = Colors.redAccent;
