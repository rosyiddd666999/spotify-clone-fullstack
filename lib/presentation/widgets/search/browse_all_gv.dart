import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';

import '../../../core/configs/constans/app_urls.dart';
import '../../../core/configs/themes/app_colors.dart';
import '../../../core/routes/routes.dart';

class BrowseAlGridView extends StatelessWidget {
  const BrowseAlGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var urlAlbums = '${AppImages.format}?${AppURLs.mediaAlt}';
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.94,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            mainAxisExtent: MediaQuery.of(context).size.height * 0.12,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            late String title;
            late String imageUrl;
            late Color colors;
            late VoidCallback onTap;

            switch (index) {
              // case 0:
              //   title = "Music Indonesia";
              //   imageUrl = '${AppURLs.albumsFirestorage}indonesia$urlAlbums';
              //   colors = AppColors.green;
              //   onTap = () => context.goNamed(
              //         Routes.artistSearch,
              //         pathParameters: {'artist': 'billie eilish'},
              //       );
              //   break;
              case 0:
                title = "Pop";
                imageUrl = '${AppURLs.albumsFirestorage}pop$urlAlbums';
                colors = AppColors.teal;
                onTap = () => context.goNamed(
                      Routes.genresSearch,
                      pathParameters: {
                        'genres': 'pop,indie-pop',
                        'nameGenresPlaylist': 'pop',
                      },
                    );
                break;
              case 1:
                title = "Chill";
                imageUrl = '${AppURLs.albumsFirestorage}chill$urlAlbums';
                colors = AppColors.pink;
                onTap = () => context.goNamed(
                      Routes.activityTypeSearch,
                      pathParameters: {'activityType': 'chill'},
                    );
                break;
              case 2:
                title = "Focus";
                imageUrl = '${AppURLs.albumsFirestorage}focus$urlAlbums';
                colors = AppColors.coralRed;
                onTap = () => context.goNamed(
                      Routes.activityTypeSearch,
                      pathParameters: {'activityType': 'focus'},
                    );
                break;
              case 3:
                title = "Workout";
                imageUrl = '${AppURLs.albumsFirestorage}workout$urlAlbums';
                colors = AppColors.darkGrey;
                onTap = () => context.goNamed(
                      Routes.activityTypeSearch,
                      pathParameters: {'activityType': 'workout'},
                    );
                break;
              case 4:
                title = "Sleep";
                imageUrl = '${AppURLs.albumsFirestorage}sleep$urlAlbums';
                colors = AppColors.grey;
                onTap = () => context.goNamed(
                      Routes.activityTypeSearch,
                      pathParameters: {'activityType': 'sleep'},
                    );
                break;
              case 5:
                title = "Party";
                imageUrl = '${AppURLs.albumsFirestorage}party$urlAlbums';
                colors = AppColors.taupe;
                onTap = () => context.goNamed(
                      Routes.activityTypeSearch,
                      pathParameters: {'activityType': 'party'},
                    );
                break;
              case 6:
                title = "Reflective";
                imageUrl = '${AppURLs.albumsFirestorage}reflective$urlAlbums';
                colors = AppColors.green;
                onTap = () => context.goNamed(
                      Routes.activityTypeSearch,
                      pathParameters: {'activityType': 'reflective'},
                    );
                break;
              case 7:
                title = "Rock";
                imageUrl = '${AppURLs.albumsFirestorage}rock$urlAlbums';
                colors = AppColors.red;
                onTap = () => context.goNamed(
                      Routes.genresSearch,
                      pathParameters: {
                        'genres': 'rock',
                        'nameGenresPlaylist': 'rock',
                      },
                    );
                break;
              case 8:
                title = "Post-\nBritpop";
                imageUrl = '${AppURLs.albumsFirestorage}post-britpop$urlAlbums';
                colors = AppColors.taupe;
                onTap = () => context.goNamed(
                      Routes.genresSearch,
                      pathParameters: {'genres': 'post-britpop'},
                    );
                break;
              case 9:
                title = "R & B";
                imageUrl = '${AppURLs.albumsFirestorage}r & b$urlAlbums';
                colors = AppColors.tangerine;
                onTap = () => context.goNamed(
                      Routes.genresSearch,
                      pathParameters: {
                        'genres': 'r & b,reggae',
                        'nameGenresPlaylist': 'r & b',
                      },
                    );
                break;
              case 10:
                title = "Electro-\nPop";
                imageUrl = '${AppURLs.albumsFirestorage}electro-pop$urlAlbums';
                colors = AppColors.blue;
                onTap = () => context.goNamed(
                      Routes.genresSearch,
                      pathParameters: {
                        'genres': 'electro-pop',
                        'nameGenresPlaylist': 'electro-pop'
                      },
                    );
                break;
              case 11:
                title = "Pop-Punk";
                imageUrl = '${AppURLs.albumsFirestorage}pop-punk$urlAlbums';
                colors = AppColors.sage;
                onTap = () => context.goNamed(
                      Routes.genresSearch,
                      pathParameters: {
                        'genres': 'pop-punk',
                        'nameGenresPlaylist': 'pop-punk'
                      },
                    );
                break;
              // case 13:
              //   title = "Anime";
              //   imageUrl = '${AppURLs.albumsFirestorage}anime$urlAlbums';
              //   colors = AppColors.coralRed;
              //   onTap = () => context.goNamed(
              //         Routes.genresSearch,
              //         pathParameters: {'genres': 'alternative'},
              //       );
              //   break;
            }
            return GestureDetector(
              onTap: onTap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Stack(
                  clipBehavior: Clip.hardEdge,
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
                      bottom: 1,
                      child: Transform.rotate(
                        angle: pi / 8,
                        child: Container(
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
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
