import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/presentation/bloc/tabs/tabs_library_cubit.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/constans/app_urls.dart';
import '../../../core/configs/themes/app_colors.dart';
import '../../../core/routes/routes.dart';
import '../../bloc/profile_info/profile_info_cubit.dart';
import '../../bloc/profile_info/profile_info_state.dart';
import '../../widgets/library/list_item.dart';
import '../../widgets/my_drawer.dart';

class LibraryPage extends StatelessWidget {
  LibraryPage({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: const MyDrawer(),
        body: BlocBuilder<TabsLibraryCubit, int>(
          builder: (context, state) {
            return DefaultTabController(
              length: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    _libraryHeader(),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: _likeSongs(context),
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

  Row _libraryHeader() {
    return Row(
      children: [
        BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return const CircularProgressIndicator();
            }
            if (state is ProfileInfoLoaded) {
              return GestureDetector(
                onTap: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                    color: AppColors.grey,
                    image: DecorationImage(
                      image: state.userEntity.imageURL != null
                          ? NetworkImage(
                              state.userEntity.imageURL!,
                            )
                          : const AssetImage(
                              AppURLs.defaultImage,
                            ) as ImageProvider,
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
        const SizedBox(
          width: 16,
        ),
        const Text(
          'Your Library',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        )
      ],
    );
  }
}

Widget _likeSongs(BuildContext context) {
  var urlAlbums = '${AppImages.format}?${AppURLs.mediaAlt}';

  List<String> title = [
    'Liked Music',
  ];
  List<String> subTitle = [
    'Playlist',
  ];

  List<String> image = [
    '${AppURLs.albumsFirestorage}favorite$urlAlbums',
  ];

  List<String> routes = [
    Routes.likedSongs,
  ];
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListItems(
          title: title,
          subTitle: subTitle,
          image: image,
          routes: routes,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
