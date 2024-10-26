import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/core/configs/playlist/song.dart';
import 'package:spotify_clone/core/configs/to_uppercase/to_uppercase.dart';
import 'package:spotify_clone/presentation/bloc/song/song_player/song_player_cubit.dart';
import 'package:spotify_clone/presentation/widgets/global_components/song_item_list.dart';
import '../../../common/widgets/app_bar/default_app_bar.dart';
import '../../../core/configs/themes/app_colors.dart';
import '../../bloc/song/favorite_song/favorite_song_cubit.dart';

class LikedMusicPage extends StatelessWidget {
  const LikedMusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        title: Text(
          toTitleCase(
            'like music',
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
          child: BlocProvider(
            create: (context) =>
                FavoriteSongsCubit(context.read<SongPlayerCubit>())
                  ..getFavoriteSongs(),
            child: BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is FavoriteSongsLoaded) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final songEntity = state.favoriteSongs[index];
                          return GestureDetector(
                              onTap: () {
                                context.read<FavoriteSongsCubit>().onSongTap(
                                      index: index,
                                      namePlaylist: AppSong.likeSongs,
                                    );
                                context
                                    .read<SongPlayerCubit>()
                                    .jumpToSong(index: index);
                              },
                              child: SongItemList(
                                songEntity: songEntity,
                                currentIndex: index,
                              ));
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                        itemCount: state.favoriteSongs.length,
                      ),
                    ],
                  );
                }
                if (state is FavoriteSongsFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
