import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Títulos
  static const TextStyle title1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: 0.5,
  );

  static const TextStyle title2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryDark,
  );

  // Subtítulos
  static const TextStyle subtitle1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: AppColors.white,
    letterSpacing: 0.3,
  );

  // Labels de campo
  static const TextStyle fieldLabel = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );

  // Texto de hints
  static const TextStyle fieldHint = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.greyText,
  );

  // Texto de botão
  static const TextStyle buttonText = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  // Texto pequeno (credenciais)
  static const TextStyle small = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
  );

  // Texto regular
  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}
