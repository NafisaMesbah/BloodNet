import 'package:bloodnet/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Appstyles {
  static final headingTextStyle = GoogleFonts.lobsterTwo(
    fontSize: SizeConfig.getProportionateScreenHeight(20),
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static final titleTextStyle = GoogleFonts.lobsterTwo(
    fontSize: SizeConfig.getProportionateScreenHeight(18),
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
  static final normalTextStyle = GoogleFonts.lobsterTwo(
    fontSize: SizeConfig.getProportionateScreenHeight(15),
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );
  static const mainColor = Color(0xFF680c07);
}
