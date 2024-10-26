import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/constans/app_urls.dart';
import '../../../core/routes/routes.dart';

class TopGenresMix extends StatelessWidget {
  const TopGenresMix({super.key});

  @override
  Widget build(BuildContext context) {
    var urlAlbums = '${AppImages.format}?${AppURLs.mediaAlt}';

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(
              width: 16,
            ),
            itemBuilder: (context, index) {
              late String cover;
              late String moreArtist;
              late VoidCallback onTap;

              switch (index) {
                case 0:
                  cover = '${AppURLs.albumsFirestorage}pop mix$urlAlbums';
                  moreArtist = 'Olivia Rodrigo, Ed Sheran, and Madison Beer';
                  onTap = () => context.goNamed(
                        Routes.genresHome,
                        pathParameters: {
                          'genres': 'pop',
                          'nameGenresPlaylist': 'pop mix',
                        },
                      );
                  break;
                case 1:
                  cover =
                      '${AppURLs.albumsFirestorage}alternative-rock mix$urlAlbums';
                  moreArtist = 'Olivia Rodrigo, Ed Sheran and Madison Beer';
                  onTap = () => context.goNamed(
                        Routes.genresHome,
                        pathParameters: {
                          'genres': 'alternative-rock',
                          'nameGenresPlaylist': 'alternative-rock mix',
                        },
                      );
                  break;
                case 2:
                  cover = '${AppURLs.albumsFirestorage}r & b mix$urlAlbums';
                  moreArtist = 'Bruno Mars, The Weeknd, and Madison Beer';
                  onTap = () => context.goNamed(
                        Routes.genresHome,
                        pathParameters: {
                          'genres': 'r & b',
                          'nameGenresPlaylist': 'r & b-rock mix',
                        },
                      );
                  break;
                case 3:
                  cover =
                      '${AppURLs.albumsFirestorage}alternative mix$urlAlbums';
                  moreArtist = 'Olivia Rodrigo, Ed Sheran and Madison Beer';
                  onTap = () => context.goNamed(
                        Routes.genresHome,
                        pathParameters: {
                          'genres': 'alternative',
                          'nameGenresPlaylist': 'alternative mix',
                        },
                      );
                  break;
                case 4:
                  cover = '${AppURLs.albumsFirestorage}rock mix$urlAlbums';
                  moreArtist = 'Avenged Savenfold, Linkin Park and Queen';
                  onTap = () => context.goNamed(
                        Routes.genresHome,
                        pathParameters: {
                          'genres': 'rock',
                          'nameGenresPlaylist': 'rock mix',
                        },
                      );
                  break;
              }
              return GestureDetector(
                onTap: onTap,
                child: SizedBox(
                  width: 145,
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        moreArtist,
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: 5,
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}
