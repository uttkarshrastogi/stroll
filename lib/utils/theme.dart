import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF4F4CB1);
  static const lightPrimary = Color(0xFFCFCFFE);
  static const textPrimary = Color(0xFFB5B2FF);
  static const gray = Color(0xFFAEADAF);
  static const darkGray = Color(0xFF5C6770);
  static const heading = Color(0xFFF5F5F5);
  static const lightGray = Color(0xFFB0B0B0);
  static const midGray = Color(0xFF505050);
  static const fadedText = Color(0xFFCBC9FF);
  static const waveformDark = Color(0xFF36393E);
  static const backgroundOverlay = Colors.black;
  static const red = Color(0xFFBE2020);
}

class AppTextStyles {
  static const title = TextStyle(color: Colors.white, fontSize: 22);
  static const subtitle = TextStyle(color: AppColors.fadedText, fontSize: 13);
  static const label = TextStyle(
    color: Colors.white,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );
  static const smallGray = TextStyle(
    color: AppColors.gray,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static const timerActive = TextStyle(
    color: AppColors.gray,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const heading = TextStyle(
    color: AppColors.heading,
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );
  static const navTitle = TextStyle(color: Colors.white, fontSize: 18);
  static const redAction = TextStyle(color: Colors.red, fontSize: 16);
}
