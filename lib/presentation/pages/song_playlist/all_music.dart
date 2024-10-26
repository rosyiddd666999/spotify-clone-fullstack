import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/core/configs/to_uppercase/to_uppercase.dart';
import 'package:spotify_clone/presentation/bloc/song/play_list/play_list_cubit.dart';
import 'package:spotify_clone/presentation/bloc/song/song_player/song_player_cubit.dart';

import '../../../common/widgets/app_bar/default_app_bar.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/constans/app_urls.dart';
import '../../../core/configs/playlist/song.dart';
import '../../../core/configs/themes/app_colors.dart';
import '../../../domain/entities/song/song_entity.dart';
import '../../bloc/song/artist_songs/artist_songs_cubit.dart';
import '../../widgets/global_components/playlist_componens.dart';
import '../../widgets/global_components/playlist_images.dart';
import '../../widgets/global_components/song_item_list.dart';

class ALlMusicPage extends StatelessWidget {
  const ALlMusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: BasicAppbar(
          title: Text(
            toTitleCase(
              'all music',
            ),
            style: const TextStyle(fontSize: 14, color: AppColors.primary),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<PlayListCubit, PlayListState>(
              builder: (context, state) {
                if (state is PlayListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is PlayListLoaded) {
                  return BlocListener<SongPlayerCubit, SongPlayerState>(
                    listener: (context, state) {},
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        const AlbumsImage(
                          imageUrl:
                              '${AppURLs.albumsFirestorage}music${AppImages.format}?${AppURLs.mediaAlt}', // conver list to string
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
                                    AppSong.playListSongs &&
                                songPlayerCubit.currentlyPlayingSong != null) {
                              songPlayerCubit.playOrPauseSong();
                            } else {
                              final newsSongsCubit =
                                  context.read<ArtistSongsCubit>();
                              newsSongsCubit.onSongTap(
                                  namePlaylist: AppSong.playListSongs);

                              songPlayerCubit.playOrPauseSong();
                            }
                          },
                          namePlaylist: AppSong.playListSongs,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        _songs(state.songs),
                        const SizedBox(height: 80),
                      ],
                    ),
                  );
                }
                if (state is PlayListFailure) {
                  Center(
                    child: Text(state.message),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        SongEntity songEntity = songs[index];
        return GestureDetector(
          onTap: () {
            final songPlayerCubit = context.read<PlayListCubit>();
            songPlayerCubit.onSongTap(
              index: index,
              namePlaylist: AppSong.playListSongs,
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
