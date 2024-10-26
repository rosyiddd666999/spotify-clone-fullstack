import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/common/helpers/is_theme_bool.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/to_uppercase/to_uppercase.dart';
import '../../../common/helpers/format_duration.dart';
import '../../../common/widgets/favorite_button/favorite_button_song.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/constans/app_urls.dart';
import '../../../core/configs/themes/app_colors.dart';
import '../../../domain/entities/song/song_entity.dart';
import '../../bloc/song/song_player/song_player_cubit.dart';

class SongPlayerPage extends StatelessWidget {
  const SongPlayerPage(
    this.initialIndexS, {
    super.key,
    required this.songs,
  });

  final List<SongEntity> songs;
  final int initialIndexS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: context.read<SongPlayerCubit>(),
        child: BlocListener<SongPlayerCubit, SongPlayerState>(
          listener: (context, state) {
            if (state is SongPlayerLoaded) {}
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const SizedBox(height: 25),
                _songHeader(context),
                const SizedBox(height: 25),
                _songCover(),
                const SizedBox(height: 40),
                _songDetail(),
                const SizedBox(height: 30),
                _songPlayer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _songHeader(BuildContext context) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoaded) {
          final songEntity = state.songs[state.currentIndex];
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  context.isDarkMode
                      ? AppVectors.arrowDown
                      : AppVectors.arrowDown,
                  height: 12,
                ),
              ),
              const Text(
                'Now Playing',
                style: TextStyle(fontSize: 14, color: AppColors.primary),
              ),
              FavoriteButtonSong(songEntity: songEntity),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _songCover() {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoaded) {
          final songEntity = state.currentlyPlayingSong;

          return Container(
            height: MediaQuery.of(context).size.height * 0.40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "${AppURLs.coverFirestorage}${songEntity.artist} - ${songEntity.title}${AppImages.format}?${AppURLs.mediaAlt}",
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _songDetail() {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoaded) {
          final songEntity = state.songs[state.currentIndex];
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      toTitleCase(
                        songEntity.title,
                      ),
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      toTitleCase(songEntity.artist),
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget _songPlayer() {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
      builder: (context, state) {
        if (state is SongPlayerLoading) {
          return const CircularProgressIndicator();
        }
        if (state is SongPlayerLoaded) {
          return Column(
            children: [
              Slider(
                value: state.songPosition.inSeconds.toDouble(),
                min: 0.0,
                max: state.songDuration.inSeconds.toDouble(),
                onChanged: (value) {
                  final position = Duration(seconds: value.toInt());
                  context.read<SongPlayerCubit>().audioPlayer.seek(position);
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDuration(state.songPosition)),
                  Text(formatDuration(state.songDuration)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<SongPlayerCubit>().playPreviousSong();
                    },
                    child: SvgPicture.asset(
                      context.isDarkMode
                          ? AppVectors.proveousLight
                          : AppVectors.proveousDark,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<SongPlayerCubit>().playOrPauseSong();
                    },
                    child: Container(
                      height: 67,
                      width: 67,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.isDarkMode
                            ? AppColors.lightBackground
                            : AppColors.components,
                      ),
                      child: Center(
                          child: context
                                  .read<SongPlayerCubit>()
                                  .audioPlayer
                                  .playing
                              ? SvgPicture.asset(
                                  AppVectors.playDark,
                                  height: 26,
                                )
                              : const Icon(
                                  Icons.play_arrow,
                                  size: 50,
                                  color: AppColors.darkBackground,
                                )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<SongPlayerCubit>().playNextSong();
                    },
                    child: SvgPicture.asset(
                      context.isDarkMode
                          ? AppVectors.nextLight
                          : AppVectors.nextDark,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        if (state is SongPlayerFailure) {
          return Text('Error: ${state.message}');
        }
        return Container();
      },
    );
  }
}
