import 'package:flutter/material.dart';

class AppThemeCustom {
  ThemeData getTheme() =>
      ThemeData(useMaterial3: true, colorSchemeSeed:const  Color.fromARGB(255, 96, 33, 112));
}