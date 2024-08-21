import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    useMaterial3: false,
    fontFamily: 'Roboto',
    chipTheme: ChipThemeData(
      showCheckmark: false,
      backgroundColor: Colors.transparent,
      labelPadding: const EdgeInsets.all(6),
      selectedColor: const Color(0xff2188FF),
      labelStyle: TextStyle(color: ChipLabelColor()),
      iconTheme: IconThemeData(color: ChipLabelColor()),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
        side: const BorderSide(color: Color(0xffD8DFE6)),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff17192D)),
    listTileTheme: ListTileThemeData(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xffEAEFF3),
      prefixIconColor: const Color(0xff8E98A3),
      hintStyle: const TextStyle(color: Color(0xff8E98A3)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      foregroundColor: Colors.white,
      backgroundColor: Color(0xff17192D),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
  );
}

class ChipLabelColor extends Color implements WidgetStateColor {
  ChipLabelColor() : super(_default);

  static const _default = 0xff77818C;

  @override
  Color resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.selected)) return Colors.white;
    return const Color(_default);
  }
}
