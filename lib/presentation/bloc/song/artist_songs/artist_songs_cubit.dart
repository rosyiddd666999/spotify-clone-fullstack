import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/usecases/song/get_artist_songs.dart';
import 'package:spotify_clone/presentation/bloc/song/song_player/song_player_cubit.dart';
import 'package:spotify_clone/service_locator.dart';

import '../../../../domain/entities/song/song_entity.dart';

part 'artist_songs_state.dart';

class ArtistSongsCubit extends Cubit<ArtistSongsState> {
  final SongPlayerCubit songPlayerCubit;

  ArtistSongsCubit(this.songPlayerCubit) : super(ArtistSongsLoading());

  Future<void> artistSongs(String artist) async {
    var returnedSongs = await sl<GetArtistSongsUseCase>().call(params: artist);
    returnedSongs.fold(
      (failure) {
        emit(
          ArtistSongsFailure('Failed to get list of artist songs: $failure'),
        );
      },
      (data) {
        emit(
          ArtistSongsLoaded(songs: data),
        );
      },
    );
  }

  Future<void> fetchSongsForMultipleArtists(List<String> artistNames) async {
    emit(ArtistSongsLoading());
    List<SongEntity> allSongs = [];

    for (var artist in artistNames) {
      final result = await sl<GetArtistSongsUseCase>().call(params: artist);
      result.fold(
        (failure) => emit(
            ArtistSongsFailure('Failed to get list of artist songs: $failure')),
        (songs) => allSongs.addAll(songs),
      );
    }
    emit(ArtistSongsLoaded(songs: allSongs));
  }

  void onSongTap({int? index, String? namePlaylist}) {
    final currentState = state;

    final currentNamePlaylist = namePlaylist!;

    if (currentState is ArtistSongsLoaded) {
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
