import 'package:flutter/material.dart';
import 'package:spotify_clone/core/configs/themes/app_colors.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/constans/app_urls.dart';
import '../../../core/configs/to_uppercase/to_uppercase.dart';
import '../../../domain/entities/song/song_entity.dart';
import '../../../common/helpers/is_theme_bool.dart';

class SongItemCard extends StatelessWidget {
  const SongItemCard({
    super.key,
    required this.songEntity,
  });

  final SongEntity songEntity;

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    bool isTrue = songEntity != null;
    String imageUrl = isTrue
        ? "${AppURLs.coverFirestorage}${songEntity.artist} - ${songEntity.title}${AppImages.format}?${AppURLs.mediaAlt}"
        : AppURLs.defaultCover;

    return SizedBox(
      width: 145,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.network(
                      AppURLs.defaultCover,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            toTitleCase(
              songEntity.title,
            ),
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              color: context.isDarkMode
                  ? AppColors.lightBackground
                  : AppColors.darkBackground,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            toTitleCase(
              songEntity.artist,
            ),
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
