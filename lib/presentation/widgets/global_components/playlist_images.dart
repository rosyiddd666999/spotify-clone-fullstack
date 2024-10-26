import 'package:flutter/material.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/constans/app_urls.dart';

class AlbumsImage extends StatelessWidget {
  const AlbumsImage({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Image.network(
        imageUrl ?? AppURLs.defaultCover,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            AppImages.cover,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
