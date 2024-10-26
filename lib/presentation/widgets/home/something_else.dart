import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/constans/app_urls.dart';
import '../../../core/routes/routes.dart';

class SomethingElse extends StatelessWidget {
  const SomethingElse({super.key});

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
                  cover = '${AppURLs.albumsFirestorage}new$urlAlbums';
                  moreArtist = 'Bruno Mars, Conan Grey and Billie Eilish';
                  onTap = () {
                    final startDate = DateTime(2023, 1, 1).toIso8601String();
                    final endDate = DateTime.now().toIso8601String();
                    context.goNamed(
                      Routes.releaseDateHome,
                      pathParameters: {
                        'startDate': startDate,
                        'endDate': endDate,
                        'nameRDPlaylist': 'new',
                      },
                    );
                  };
                  break;
                case 1:
                  cover = '${AppURLs.albumsFirestorage}2010 - 2020$urlAlbums';
                  moreArtist = 'Charlie Puth, Bruno Mars and Anne Merie';
                  onTap = () {
                    final startDate = DateTime(2010, 1, 1).toIso8601String();
                    final endDate =
                        DateTime(2020, 12, 31, 23, 59, 59).toIso8601String();

                    context.goNamed(
                      Routes.releaseDateHome,
                      pathParameters: {
                        'startDate': startDate,
                        'endDate': endDate,
                        'nameRDPlaylist': '2010 - 2020',
                      },
                    );
                  };
                  break;
                case 2:
                  cover = '${AppURLs.albumsFirestorage}old$urlAlbums';
                  moreArtist = 'Queen, Guns N\' Rosses and Green Day';
                  onTap = () {
                    final startDate = DateTime(1970, 1, 1).toIso8601String();
                    final endDate =
                        DateTime(2000, 12, 31, 23, 59, 59).toIso8601String();
                    context.goNamed(Routes.releaseDateHome, pathParameters: {
                      'startDate': startDate,
                      'endDate': endDate,
                      'nameRDPlaylist': 'old',
                    });
                  };
                  break;
                case 3:
                  cover = '${AppURLs.albumsFirestorage}pop$urlAlbums';
                  moreArtist = 'Olivia Rodrigo, Ed Sheran and Madison Beer';
                  onTap = () => context.goNamed(
                        Routes.genresHome,
                        pathParameters: {
                          'genres': 'pop',
                          'nameGenresPlaylist': 'pop',
                        },
                      );
                  break;
                case 4:
                  cover = '${AppURLs.albumsFirestorage}rock$urlAlbums';
                  moreArtist = 'Avenged Savenfold, Linkin Park and Queen';
                  onTap = () => context.goNamed(
                        Routes.genresHome,
                        pathParameters: {
                          'genres': 'pop-punk',
                          'nameGenresPlaylist': 'rock',
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
