import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/helpers/is_theme_bool.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/themes/app_colors.dart';
import 'package:spotify_clone/presentation/bloc/song/song_player/song_player_cubit.dart';

import '../../../common/widgets/favorite_button/favorite_button_song.dart';
import '../../../core/configs/constans/app_urls.dart';
import '../../../core/configs/to_uppercase/to_uppercase.dart';
import '../../../domain/entities/song/song_entity.dart';

class SongItemList extends StatelessWidget {
  const SongItemList({
    super.key,
    required this.songEntity,
    required this.currentIndex,
  });

  final SongEntity songEntity;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage(
                    "${AppURLs.coverFirestorage}${songEntity.artist} - ${songEntity.title}${AppImages.format}?${AppURLs.mediaAlt}",
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.58,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<SongPlayerCubit, SongPlayerState>(
                    builder: (context, state) {
                      final songPlayerCubit = context.read<SongPlayerCubit>();

                      final isCurrentlyPlaying =
                          songPlayerCubit.currentlyPlayingSong != null &&
                              songPlayerCubit.currentlyPlayingSong!.songId ==
                                  songEntity.songId &&
                              songPlayerCubit.audioPlayer.playing;
                      return Text(
                        toTitleCase(
                          songEntity.title,
                        ),
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isCurrentlyPlaying
                              ? AppColors.primary
                              : context.isDarkMode
                                  ? AppColors.lightBackground
                                  : AppColors
                                      .darkBackground, // Default ke putih
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    toTitleCase(
                      songEntity.artist,
                    ),
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 11),
                  ),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: FavoriteButtonSong(
            songEntity: songEntity,
          ),
        ),
      ],
    );
  }
}
