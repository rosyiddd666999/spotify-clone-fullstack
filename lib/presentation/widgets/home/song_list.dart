import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/core/configs/playlist/song.dart';
import 'package:spotify_clone/presentation/bloc/song/release_date_songs.dart/release_date_songs_cubit.dart';
import 'package:spotify_clone/presentation/bloc/song/song_player/song_player_cubit.dart';

import '../../../domain/entities/song/song_entity.dart';
import '../global_components/song_item_card.dart';

class SongsList extends StatelessWidget {
  const SongsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BlocBuilder<ReleaseDateSongsCubit, ReleaseDateSongsState>(
        builder: (context, state) {
          if (state is ReleaseDateSongsLoading) {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
          if (state is ReleaseDateSongsLoaded) {
            return _songs(state.songs);
          }
          if (state is ReleaseDateSongsFailure) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
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
                  context.read<ReleaseDateSongsCubit>().onSongTap(
                        index: index,
                        namePlaylist: AppSong.newSongs,
                      );
                  context.read<SongPlayerCubit>().jumpToSong(index: index);
                },
                child: SongItemCard(
                  songEntity: songs[index],
                ),
              );
            },
            itemCount: songs.length,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
