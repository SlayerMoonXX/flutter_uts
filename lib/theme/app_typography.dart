import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextStyle get headlineExtraBold =>
      GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.w800);

  static TextStyle get headlineBold =>
      GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.w700);

  static TextStyle get subHeadlineExtraBold =>
      GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w800);

  static TextStyle get subHeadlineBold =>
      GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w700);

  static TextStyle get textBold =>
      GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w700);

  static TextStyle get textSemiBold =>
      GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w600);

  static TextStyle get textRegular =>
      GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle get commentRegular =>
      GoogleFonts.nunito(fontSize: 12, fontWeight: FontWeight.w400);
}
