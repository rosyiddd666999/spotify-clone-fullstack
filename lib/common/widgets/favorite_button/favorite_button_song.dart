import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_clone/common/bloc/favorite_button_song/favorite_button_song_state.dart';

import '../../../core/configs/assets/app_vectors.dart';
import '../../../domain/entities/song/song_entity.dart';
import '../../bloc/favorite_button_song/favorite_button_song_cubit.dart';

class FavoriteButtonSong extends StatelessWidget {
  final SongEntity songEntity;
  final Function? function;
  const FavoriteButtonSong(
      {required this.songEntity, this.function, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonSongCubit(),
      child: BlocBuilder<FavoriteButtonSongCubit, FavoriteButtonSongState>(
        builder: (context, state) {
          if (state is FavoriteButtonSongInitial) {
            return GestureDetector(
              onTap: () async {
                await context
                    .read<FavoriteButtonSongCubit>()
                    .favoriteButtonSongUpdated(songEntity.songId);
                if (function != null) {
                  function!();
                }
              },
              child: songEntity.isFavorite
                  ? SvgPicture.asset(
                      AppVectors.likeEnableLight,
                      width: 20,
                      height: 20,
                    )
                  : SvgPicture.asset(
                      AppVectors.likeDisableLight,
                      width: 20,
                      height: 20,
                    ),
            );
          }

          if (state is FavoriteButtonSongUpdated) {
            return GestureDetector(
              onTap: () {
                context
                    .read<FavoriteButtonSongCubit>()
                    .favoriteButtonSongUpdated(songEntity.songId);
              },
              child: state.isFavoriteSongs
                  ? SvgPicture.asset(
                      AppVectors.likeEnableLight,
                      width: 20,
                      height: 20,
                    )
                  : SvgPicture.asset(
                      AppVectors.likeDisableLight,
                      width: 20,
                      height: 20,
                    ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
