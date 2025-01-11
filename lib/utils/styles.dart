import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static var ha = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    color: AppColors.fg,
    fontSize: 22,
  );
  static var h1 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400,
    color: AppColors.fg,
    fontSize: 28,
  );
  static var sub = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    color: AppColors.fg.withAlpha(100),
    fontSize: 16,
  );
  static var body = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    color: AppColors.fg,
    fontSize: 14,
  );
  static var subAlt = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    color: AppColors.bg,
    fontSize: 16,
  );
  static var bodyAlt = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    color: AppColors.bg,
    fontSize: 14,
  );
  static var h6oi = GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
      color: AppColors.fg,
      fontSize: 14,
      shadows: [
        Shadow(
          color: Colors.grey,
          offset: Offset(0, 0),
          blurRadius: 10,
        )
      ]);
}

class AppSizing {
  static double getHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;
  static double getWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;
}

class AppColors {
  static var bg = Color(0xFF0B0B0B);
  static var bg1 = Color(0xFF121212);
  static var fg = Color(0xFFFFFFFF);
}

Widget space(double space) => SizedBox(
      height: space,
      width: space,
    );

Widget desktopph() => Container(
      // width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/ph3.svg',
            height: 100,
          ),
          Text(
            'Your Devices are on Sync',
            style: AppTypography.sub,
          ),
          space(10),
          Text(
            'Use a mobile device for best experience',
            style: AppTypography.body,
          )
        ],
      ),
    );
