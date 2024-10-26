import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/common/widgets/app_bar/default_app_bar.dart';
import 'package:spotify_clone/core/configs/assets/app_images.dart';
import 'package:spotify_clone/core/configs/playlist/song.dart';
import 'package:spotify_clone/core/configs/to_uppercase/to_uppercase.dart';
import 'package:spotify_clone/presentation/bloc/song/activity_type/activity_type_cubit.dart';
import 'package:spotify_clone/presentation/widgets/global_components/song_item_list.dart';

import '../../../core/configs/constans/app_urls.dart';
import '../../../core/configs/themes/app_colors.dart';
import '../../../domain/entities/song/song_entity.dart';
import '../../bloc/song/song_player/song_player_cubit.dart';
import '../../widgets/global_components/playlist_componens.dart';
import '../../widgets/global_components/playlist_images.dart';

class ActivityTypeSongsPage extends StatelessWidget {
  final List<String> activityType;

  const ActivityTypeSongsPage({super.key, required this.activityType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityTypeCubit(context.read<SongPlayerCubit>())
        ..activityTypeSongs(activityType),
      child: SafeArea(
        child: Scaffold(
          appBar: BasicAppbar(
            title: Text(
              toTitleCase(
                activityType[0],
              ),
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlocBuilder<ActivityTypeCubit, ActivityTypeState>(
                builder: (context, state) {
                  if (state is ActivityTypeLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ActivityTypeLoaded) {
                    return BlocListener<SongPlayerCubit, SongPlayerState>(
                      listener: (context, state) {},
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          AlbumsImage(
                            imageUrl:
                                '${AppURLs.albumsFirestorage}${activityType[0]}${AppImages.format}?${AppURLs.mediaAlt}',
                          ),
                          const SizedBox(height: 16),
                          AlbumComponents(
                            totalDuration: '3h 1min',
                            onTap: () {
                              final songPlayerCubit =
                                  context.read<SongPlayerCubit>();

                              if (songPlayerCubit.currentPlaylist ==
                                      '${AppSong.activityTypeSongs}${activityType[0]}' &&
                                  songPlayerCubit.currentlyPlayingSong !=
                                      null) {
                                songPlayerCubit.playOrPauseSong();
                              } else {
                                final activityTypeCubit =
                                    context.read<ActivityTypeCubit>();
                                activityTypeCubit.onSongTap(
                                    namePlaylist:
                                        '${AppSong.activityTypeSongs}${activityType[0]}');
                                songPlayerCubit.playOrPauseSong();
                              }
                            },
                            namePlaylist:
                                '${AppSong.activityTypeSongs}${activityType[0]}',
                          ),
                          const SizedBox(height: 16),
                          // Gunakan Expanded untuk memberikan ruang ke ListView
                          _songs(state.songs),

                          const SizedBox(height: 80),
                        ],
                      ),
                    );
                  } else if (state is ActivityTypeFailure) {
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

  Widget _songs(List<SongEntity> songs) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        SongEntity songEntity = songs[index];

        return GestureDetector(
          onTap: () {
            context.read<ActivityTypeCubit>().onSongTap(
                  index: index,
                  namePlaylist:
                      '${AppSong.activityTypeSongs}${activityType[0]}',
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
