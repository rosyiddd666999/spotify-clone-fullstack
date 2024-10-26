import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/common/helpers/is_theme_bool.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/to_uppercase/to_uppercase.dart';
import '../../core/configs/assets/app_vectors.dart';
import '../../core/configs/constans/app_urls.dart';
import '../../core/configs/themes/app_colors.dart';
import '../../domain/entities/song/song_entity.dart';
import '../bloc/song/song_player/song_player_cubit.dart';
import '../pages/song_player/song_player.dart';

class SongMiniPlayer extends StatelessWidget {
  final List<SongEntity> songs;

  const SongMiniPlayer({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        }
        if (state is SongPlayerLoaded) {
          final PageController pageController =
              PageController(initialPage: state.currentIndex);

          return SizedBox(
            height: 68,
            child: PageView.builder(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemCount: songs.length,
              onPageChanged: (index) {
                context.read<SongPlayerCubit>().jumpToSong(index: index);
              },
              itemBuilder: (context, index) {
                final songEntity = state.currentlyPlayingSong;

                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 0.95,
                          child: SongPlayerPage(
                            index,
                            songs: songs,
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 5, right: 5, left: 5),
                    height: 68,
                    padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
                    decoration: BoxDecoration(
                      color: context.isDarkMode
                          ? AppColors.darkGrey
                          : AppColors.components,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        "${AppURLs.coverFirestorage}${songEntity.artist} - ${songEntity.title}${AppImages.format}?${AppURLs.mediaAlt}",
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        toTitleCase(
                                          songEntity.title,
                                        ),
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: context.isDarkMode
                                                ? AppColors.lightBackground
                                                : AppColors.darkBackground,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Text(
                                        toTitleCase(
                                          songEntity.artist,
                                        ),
                                        style: TextStyle(
                                          color: context.isDarkMode
                                              ? Colors.white70
                                              : Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .read<SongPlayerCubit>()
                                      .playOrPauseSong();
                                },
                                child: context
                                        .read<SongPlayerCubit>()
                                        .audioPlayer
                                        .playing
                                    ? SvgPicture.asset(
                                        context.isDarkMode
                                            ? AppVectors.playLight
                                            : AppVectors.playDark,
                                      )
                                    : SvgPicture.asset(
                                        context.isDarkMode
                                            ? AppVectors.pauseLight
                                            : AppVectors.pauseDark,
                                      ),
                              ),
                            ),
                          ],
                        ),
                        _songPlayer(context),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _songPlayer(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const CircularProgressIndicator();
        }
        if (state is SongPlayerLoaded) {
          return SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: SliderComponentShape.noThumb,
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: Slider(
              value: state.songPosition.inSeconds.toDouble(),
              activeColor: AppColors.components,
              inactiveColor: Colors.white12,
              min: 0.0,
              max: state.songDuration.inSeconds.toDouble(),
              onChanged: (value) {
                final position = Duration(seconds: value.toInt());
                context.read<SongPlayerCubit>().audioPlayer.seek(position);
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
