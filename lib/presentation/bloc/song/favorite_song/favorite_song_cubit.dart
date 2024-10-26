import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/presentation/bloc/song/song_player/song_player_cubit.dart';

import '../../../../domain/entities/song/song_entity.dart';
import '../../../../domain/usecases/song/get_favorite_songs.dart';
import '../../../../service_locator.dart';

part 'favorite_song_state.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  final SongPlayerCubit songPlayerCubit;

  List<SongEntity> favoriteSongs = [];

  FavoriteSongsCubit(this.songPlayerCubit) : super(FavoriteSongsLoading());

  Future<void> getFavoriteSongs() async {
    var result = await sl<GetFavoriteSongsUseCase>().call();

    result.fold(
      (failure) {
        emit(FavoriteSongsFailure('not get list favorite songs'));
      },
      (favorite) {
        favoriteSongs = favorite;
        emit(
          FavoriteSongsLoaded(
            favoriteSongs: favoriteSongs,
          ),
        );
      },
    );
  }

  void removeSong(int index) {
    favoriteSongs.removeAt(index);
    emit(FavoriteSongsLoaded(favoriteSongs: favoriteSongs));
  }

  void onSongTap({int? index, String? namePlaylist}) {
    final currentState = state;

    final currentNamePlaylist = namePlaylist!;

    if (currentState is FavoriteSongsLoaded) {
      final songs = currentState.favoriteSongs;
      songPlayerCubit.updateSongs(songs, currentNamePlaylist);
      songPlayerCubit.switchPlaylist(currentNamePlaylist);

      if (index == null || index < 0 || index > songs.length) {
        index = Random().nextInt(songs.length);
      }

      if (songPlayerCubit.currentlyPlayingSong == null ||
          songPlayerCubit.currentlyPlayingSong!.songId != songs[index].songId) {
        songPlayerCubit.loadSong(index: index);
      } else {
        songPlayerCubit.playOrPauseSong();
      }
    }
  }
}
