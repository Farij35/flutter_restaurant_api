import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primaryColor = Color(0xFFFFFFFF);
final Color secondaryColor = Colors.orange;

final TextTheme restoTextTheme = TextTheme(
  headline1: GoogleFonts.openSans(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.openSans(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3:
  GoogleFonts.openSans(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.openSans(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5:
  GoogleFonts.openSans(fontSize: 23, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.openSans(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.openSans(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.openSans(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.libreFranklin(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.libreFranklin(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.libreFranklin(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
