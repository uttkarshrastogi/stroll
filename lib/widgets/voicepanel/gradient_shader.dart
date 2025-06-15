import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:stroll/utils/theme.dart';

Shader buildGradientShader(BuildContext context) {
  return ui.Gradient.linear(
    const Offset(0, 0),
    Offset(MediaQuery.of(context).size.width, 0),
    const [AppColors.primary, AppColors.lightPrimary],
  );
}