import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/constans/app_urls.dart';
import '../../../core/routes/routes.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return _songs();
  }

  Widget _songs() {
    List<String> nimage = [
      "${AppURLs.albumsFirestorage}billie eilish mix${AppImages.format}?${AppURLs.mediaAlt}",
      "${AppURLs.albumsFirestorage}the weeknd mix${AppImages.format}?${AppURLs.mediaAlt}",
      "${AppURLs.albumsFirestorage}bruno mars mix${AppImages.format}?${AppURLs.mediaAlt}",
      "${AppURLs.albumsFirestorage}taylor swift mix${AppImages.format}?${AppURLs.mediaAlt}",
      "${AppURLs.albumsFirestorage}coldplay mix${AppImages.format}?${AppURLs.mediaAlt}",
    ];
    List<String> artistList = [
      'The Weeknd, Conan Gray and Ruth B.',
      'Linkin Park, Neck Deep, and Dua Lipa',
      'One Direction, Ed Sheeran and Ane Marie',
      'Madison Beer, Olivia Rodrigo, and Billie Eilish',
      'Green Day, Oasis, and Queen'
    ];
    List<String> artist = [
      'billie eilish, the weeknd, conan gray, ruth b.',
      'the weeknd, linkin park, neck deep, dua lipa',
      'bruno mars, ed sheeran, one direction, anne marie',
      'taylor swift, madison beer, olivia rodrigo, billie eilish',
      'coldplay, green day, oasis, queen',
    ];

    List<String> namePlaylist = [
      'billie eilish mix',
      'the weeknd mix',
      'bruno mars mix',
      'taylor swift mix',
      'coldplay mix',
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
