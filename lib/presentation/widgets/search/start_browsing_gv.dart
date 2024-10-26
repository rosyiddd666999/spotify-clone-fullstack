import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/constans/app_urls.dart';
import '../../../core/configs/themes/app_colors.dart';
import '../../../core/routes/routes.dart';

class StartBrowsingGridView extends StatelessWidget {
  const StartBrowsingGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var urlAlbums = '${AppImages.format}?${AppURLs.mediaAlt}';
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            mainAxisExtent: MediaQuery.of(context).size.height * 0.08,
          ),
          itemCount: 2,
          itemBuilder: (context, index) {
            late String title;
            late String imageUrl;
            late Color colors;
            late VoidCallback onTap;

            switch (index) {
              case 0:
                title = "All Music";
                imageUrl = '${AppURLs.albumsFirestorage}music$urlAlbums';
                colors = AppColors.pink;
                onTap = () {
                  context.goNamed(
                    Routes.allMusic,
                  );
                };
                break;
              case 1:
                title = "New Release";
                imageUrl = '${AppURLs.albumsFirestorage}new$urlAlbums';
                colors = AppColors.purple;
                onTap = () {
                  final startDate = DateTime(2023, 1, 1).toIso8601String();
                  final endDate = DateTime.now().toIso8601String();
                  context.goNamed(
                    Routes.releaseDateSearch,
                    pathParameters: {
                      'startDate': startDate,
                      'endDate': endDate,
                      'nameRDPlaylist': 'new release',
                    },
                  );
                };
                break;
            }
            return GestureDetector(
              onTap: onTap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Stack(
                  clipBehavior: Clip.hardEdge, // Cut Container
                  children: [
                    Container(
                      color: colors,
                    ),
                    Positioned(
                      left: 8,
                      top: 10,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: -18,
                      bottom: -10,
                      child: Transform.rotate(
                        angle: pi / 8,
                        child: Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(imageUrl),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
