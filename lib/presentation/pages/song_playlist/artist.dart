import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/core/configs/to_uppercase/to_uppercase.dart';
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

class ArtistMixPage extends StatelessWidget {
  const ArtistMixPage({
    super.key,
    required this.namePlaylist,
    required this.artistNames,
  });

  final List<String> artistNames;
  final String namePlaylist;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ArtistSongsCubit>()
        ..fetchSongsForMultipleArtists(artistNames),
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
              child: BlocBuilder<ArtistSongsCubit, ArtistSongsState>(
                builder: (context, state) {
                  if (state is ArtistSongsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ArtistSongsLoaded) {
                    return BlocListener<SongPlayerCubit, SongPlayerState>(
                      listener: (context, state) {},
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          AlbumsImage(
                            imageUrl:
                                '${AppURLs.albumsFirestorage}$namePlaylist${AppImages.format}?${AppURLs.mediaAlt}', // conver list to string
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
                                      '${AppSong.artistSongs}$namePlaylist' &&
                                  songPlayerCubit.currentlyPlayingSong !=
                                      null) {
                                songPlayerCubit.playOrPauseSong();
                              } else {
                                final newsSongsCubit =
                                    context.read<ArtistSongsCubit>();
                                newsSongsCubit.onSongTap(
                                    namePlaylist:
                                        '${AppSong.artistSongs}$namePlaylist');

                                songPlayerCubit.playOrPauseSong();
                              }
                            },
                            namePlaylist: '${AppSong.artistSongs}$namePlaylist',
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
                  if (state is ArtistSongsFailure) {
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
            context.read<ArtistSongsCubit>().onSongTap(
                  index: index,
                  namePlaylist: '${AppSong.artistSongs}$namePlaylist',
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
