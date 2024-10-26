import 'package:flutter/material.dart';
import 'package:spotify_clone/common/helpers/is_theme_bool.dart';

import '../../../core/configs/themes/app_colors.dart';

class BasicAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final double? height;
  final bool colorTheme;
  const BasicAppButton(
      {required this.onPressed,
      required this.title,
      this.height,
      super.key,
      required this.colorTheme});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(height ?? 80),
            backgroundColor:
                colorTheme ? AppColors.primary : AppColors.lightBackground),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: context.isDarkMode
                ? AppColors.darkBackground
                : AppColors.lightBackground,
          ),
        ));
  }
}
