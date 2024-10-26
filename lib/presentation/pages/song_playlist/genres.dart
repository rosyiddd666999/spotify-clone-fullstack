import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/widgets/app_bar/default_app_bar.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/playlist/song.dart';
import 'package:spotify_clone/core/configs/to_uppercase/to_uppercase.dart';
import 'package:spotify_clone/presentation/bloc/song/genres_songs/genres_songs_cubit.dart';
import 'package:spotify_clone/presentation/widgets/global_components/song_item_list.dart';

import '../../../core/configs/constans/app_urls.dart';
import '../../../core/configs/themes/app_colors.dart';
import '../../../domain/entities/song/song_entity.dart';
import '../../bloc/song/song_player/song_player_cubit.dart';
import '../../widgets/global_components/playlist_componens.dart';
import '../../widgets/global_components/playlist_images.dart';

class GenresSongsPage extends StatelessWidget {
  final List<String> genres;
  final String namePlaylist;

  const GenresSongsPage(
      {super.key, required this.genres, required this.namePlaylist});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<GenresSongsCubit>()..genreSongs(genres),
      child: SafeArea(
        child: Scaffold(
          appBar: BasicAppbar(
            title: Text(
              toTitleCase(
                namePlaylist,
              ),
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: BlocBuilder<GenresSongsCubit, GenresSongsState>(
                builder: (context, state) {
                  if (state is GenresSongsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is GenresSongsLoaded) {
                    return BlocListener<SongPlayerCubit, SongPlayerState>(
                      listener: (context, state) {},
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          AlbumsImage(
                            imageUrl:
                                '${AppURLs.albumsFirestorage}$namePlaylist${AppImages.format}?${AppURLs.mediaAlt}',
                          ),
                          const SizedBox(height: 16),
                          AlbumComponents(
                            totalDuration: '3h 1min',
                            onTap: () {
                              final genresPlayerCubit =
                                  context.read<SongPlayerCubit>();

                              if (genresPlayerCubit.currentPlaylist ==
                                      '${AppSong.genresSongs}$namePlaylist' &&
                                  genresPlayerCubit.currentlyPlayingSong !=
                                      null) {
                                genresPlayerCubit.playOrPauseSong();
                              } else {
                                final genresSongsCubit =
                                    context.read<GenresSongsCubit>();
                                genresSongsCubit.onSongTap(
                                    namePlaylist:
                                        '${AppSong.genresSongs}$namePlaylist');
                                genresPlayerCubit.playOrPauseSong();
                              }
                            },
                            namePlaylist: '${AppSong.genresSongs}$namePlaylist',
                          ),
                          const SizedBox(height: 16),
                          _songs(context, state.songs),
                          const SizedBox(height: 80),
                        ],
                      ),
                    );
                  } else if (state is GenresSongsFailure) {
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

  Widget _songs(BuildContext context, List<SongEntity> songs) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        SongEntity songEntity = songs[index];
        return GestureDetector(
          onTap: () {
            context.read<GenresSongsCubit>().onSongTap(
                  index: index,
                  namePlaylist: '${AppSong.genresSongs}$namePlaylist',
                );
            context.read<SongPlayerCubit>().jumpToSong(index: index);
          },
          child: SongItemList(
            songEntity: songEntity,
            currentIndex: index,
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemCount: songs.length,
    );
  }
}
