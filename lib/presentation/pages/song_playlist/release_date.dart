import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/widgets/app_bar/default_app_bar.dart';
import 'package:spotify_clone/core/configs/playlist/song.dart';
import 'package:spotify_clone/core/configs/themes/app_colors.dart';
import 'package:spotify_clone/core/configs/to_uppercase/to_uppercase.dart';
import 'package:spotify_clone/presentation/bloc/song/release_date_songs.dart/release_date_songs_cubit.dart';
import 'package:spotify_clone/presentation/widgets/global_components/song_item_list.dart';

import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/constans/app_urls.dart';
import '../../../domain/entities/song/song_entity.dart';
import '../../bloc/song/song_player/song_player_cubit.dart';
import '../../widgets/global_components/playlist_componens.dart';
import '../../widgets/global_components/playlist_images.dart';

class ReleaseDatePage extends StatelessWidget {
  const ReleaseDatePage(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.namePlaylist});

  final Timestamp startDate;
  final Timestamp endDate;
  final String namePlaylist;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ReleaseDateSongsCubit>()
        ..releaseDateSongs(
          startDate: startDate,
          endDate: endDate,
        ),
      child: SafeArea(
        child: Scaffold(
          appBar: BasicAppbar(
            title: Text(
              toTitleCase(
                namePlaylist,
              ),
              style: const TextStyle(fontSize: 14, color: AppColors.primary),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<ReleaseDateSongsCubit, ReleaseDateSongsState>(
                builder: (context, state) {
                  if (state is ReleaseDateSongsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ReleaseDateSongsLoaded) {
                    return BlocListener<SongPlayerCubit, SongPlayerState>(
                      listener: (context, state) {},
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          AlbumsImage(
                            imageUrl:
                                '${AppURLs.albumsFirestorage}$namePlaylist${AppImages.format}?${AppURLs.mediaAlt}',
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          AlbumComponents(
                            totalDuration: '3h 1min',
                            onTap: () {
                              final songPlayerCubit =
                                  context.read<SongPlayerCubit>();

                              if (songPlayerCubit.currentPlaylist ==
                                      '${AppSong.releaaseDate}$namePlaylist' &&
                                  songPlayerCubit.currentlyPlayingSong !=
                                      null) {
                                songPlayerCubit.playOrPauseSong();
                              } else {
                                final y10Until20SongsCubit =
                                    context.read<ReleaseDateSongsCubit>();
                                y10Until20SongsCubit.onSongTap(
                                    namePlaylist:
                                        '${AppSong.releaaseDate}$namePlaylist');

                                songPlayerCubit.playOrPauseSong();
                              }
                            },
                            namePlaylist:
                                '${AppSong.releaaseDate}$namePlaylist',
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          _songs(
                            state.songs,
                            namePlaylist,
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is ReleaseDateSongsFailure) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _songs(List<SongEntity> songs, String namePlaylist) {
  return ListView.separated(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    itemBuilder: (context, index) {
      SongEntity songEntity = songs[index];
      return GestureDetector(
        onTap: () {
          final songPlayerCubit = context.read<ReleaseDateSongsCubit>();
          songPlayerCubit.onSongTap(
            index: index,
            namePlaylist: '${AppSong.releaaseDate}$namePlaylist',
          );

          context.read<SongPlayerCubit>().jumpToSong(index: index);
        },
        child: SongItemList(
          songEntity: songEntity,
          currentIndex: index,
        ),
      );
    },
    separatorBuilder: (context, index) => const SizedBox(
      height: 20,
    ),
    itemCount: songs.length,
  );
}
