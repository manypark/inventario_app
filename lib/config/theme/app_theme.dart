import 'package:flutter/material.dart';

const colorSeed = Color(0xff424CB8);
const scaffoldBackgroundColor = Color(0xFFFFFFFF);

class AppTheme {

  ThemeData getTheme() => ThemeData(

    ///* General
    useMaterial3   : true,
    colorSchemeSeed: colorSeed,

    ///*Texts
    textTheme: const TextTheme( 
      titleLarge  : TextStyle( fontSize: 28, color: Colors.white ),
      titleMedium : TextStyle( fontSize: 24, color: Colors.white ),
      titleSmall  : TextStyle( fontSize: 20, color: Colors.black ),
    ),

    ///* Scaffold Background Color
    scaffoldBackgroundColor: scaffoldBackgroundColor,

  );

}