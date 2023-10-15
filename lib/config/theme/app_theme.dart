import 'package:flutter/material.dart';

const colorSeed = Color(0xff424CB8);
const scaffoldBackgroundColor = Color(0xFFFFFFFF);

class AppTheme {

  ThemeData getTheme() => ThemeData(

    ///* General
    useMaterial3   : true,
    colorSchemeSeed: colorSeed,

    ///* Scaffold Background Color
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    
  );

}