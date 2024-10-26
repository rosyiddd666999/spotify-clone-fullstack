import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/constans/app_urls.dart';
import '../../../core/routes/routes.dart';

class BestOfArtist extends StatelessWidget {
  const BestOfArtist({super.key});

  @override
  Widget build(BuildContext context) {
    return _songs();
  }

  Widget _songs() {
    List<String> nimage = [
      "${AppURLs.albumsFirestorage}this is bruno mars${AppImages.format}?${AppURLs.mediaAlt}",
      "${AppURLs.albumsFirestorage}this is billie eilish${AppImages.format}?${AppURLs.mediaAlt}",
      "${AppURLs.albumsFirestorage}this is the weeknd${AppImages.format}?${AppURLs.mediaAlt}",
      "${AppURLs.albumsFirestorage}this is ed sheeran${AppImages.format}?${AppURLs.mediaAlt}",
      "${AppURLs.albumsFirestorage}this is taylor swift${AppImages.format}?${AppURLs.mediaAlt}",
    ];
    List<String> artistList = [
      'This is Bruno Mars. The Essential Track, all in one playlist.',
      'The essential Blillie Eilish track, all in one playlist',
      'The essential track, all in one playlist',
      'ALl his biggest hits, in one place.',
      'The essential track, all in one playlist',
    ];
    List<String> artist = [
      'bruno mars',
      'billie eilish',
      'the weeknd',
      'ed sheeran',
      'taylor swift',
    ];

    List<String> namePlaylist = [
      'this is bruno mars',
      'this is billie eilish',
      'this is the weeknd',
      'this is ed sheeran',
      'this is taylor swift',
    ];

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
              return GestureDetector(
                onTap: () {
                  context.goNamed(Routes.artistName, pathParameters: {
                    'artist': artist[index],
                    'nameArtistPlaylist': namePlaylist[index],
                  });
                },
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
                                nimage[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        artistList[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 2,
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
