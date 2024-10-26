import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/core/configs/themes/app_colors.dart';
import 'package:spotify_clone/presentation/widgets/song_mini_player.dart';
import '../../core/configs/assets/app_vectors.dart';
import '../bloc/song/song_player/song_player_cubit.dart';

class MyDashboard extends StatelessWidget {
  final StatefulNavigationShell shell;

  const MyDashboard({
    super.key,
    required this.shell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          shell,
          BlocListener<SongPlayerCubit, SongPlayerState>(
            listener: (context, state) {},
            child: BlocBuilder<SongPlayerCubit, SongPlayerState>(
              builder: (context, songState) {
                if (songState is SongPlayerLoaded) {
                  return Positioned(
                    bottom: 2,
                    left: 0,
                    right: 0,
                    child: SongMiniPlayer(
                      songs: songState.songs,
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: shell.goBranch,
        currentIndex: shell.currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: SvgPicture.asset(
                AppVectors.homeDisable,
                width: 22,
                height: 22,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: SvgPicture.asset(
                AppVectors.homeEnable,
                width: 22,
                height: 22,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: SvgPicture.asset(
                AppVectors.searchDisable,
                width: 22,
                height: 22,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: SvgPicture.asset(
                AppVectors.searchEnable,
                width: 22,
                height: 22,
              ),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: SvgPicture.asset(
                AppVectors.libraryDisable,
                width: 22,
                height: 22,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 6.0),
              child: SvgPicture.asset(
                AppVectors.libraryEnable,
                width: 22,
                height: 22,
              ),
            ),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: SvgPicture.asset(
                AppVectors.logoDisable,
                width: 26,
                height: 26,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: SvgPicture.asset(
                AppVectors.logoGreen,
                width: 26,
                height: 26,
              ),
            ),
            label: 'Spotify',
          ),
        ],
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontSize: 10,
          height: 2.5,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 10,
          height: 2.5,
        ),
      ),
    );
  }
}
