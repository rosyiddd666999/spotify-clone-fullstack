import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/common/helpers/is_theme_bool.dart';

import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/themes/app_colors.dart';
import 'search_screen.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchScreen(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: context.isDarkMode
                ? AppColors.lightBackground
                : AppColors.components,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              SvgPicture.asset(AppVectors.search),
              const SizedBox(width: 12),
              const Text(
                "What do you want to listen to?",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.darkGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
