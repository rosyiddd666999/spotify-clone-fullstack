import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/usecases/song/get_genres_songs.dart';
import 'package:spotify_clone/presentation/bloc/song/song_player/song_player_cubit.dart';

import '../../../../domain/entities/song/song_entity.dart';
import '../../../../service_locator.dart';

part 'genres_songs_state.dart';

class GenresSongsCubit extends Cubit<GenresSongsState> {
  final SongPlayerCubit songPlayerCubit;

  GenresSongsCubit(this.songPlayerCubit) : super(GenresSongsLoading());

  Future<void> genreSongs(List<String> genres) async {
    var returnedSongs = await sl<GetGenresSongsUseCase>().call(params: genres);
    returnedSongs.fold(
      (failure) {
        emit(
          GenresSongsFailure('Failed to get list of genres songs: $failure'),
        );
      },
      (data) {
        emit(
          GenresSongsLoaded(songs: data),
        );
      },
    );
  }

  void onSongTap({int? index, String? namePlaylist}) {
    final currentState = state;
    final currentNamePlaylist = namePlaylist!;
    if (currentState is GenresSongsLoaded) {
      final songs = currentState.songs;
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
