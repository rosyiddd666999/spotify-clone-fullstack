import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/entities/song/song_entity.dart';
import 'package:spotify_clone/domain/usecases/song/get_release_date_songs.dart';
import 'package:spotify_clone/presentation/bloc/song/song_player/song_player_cubit.dart';
import '../../../../service_locator.dart';

part 'release_date_songs_state.dart';

class ReleaseDateSongsCubit extends Cubit<ReleaseDateSongsState> {
  final SongPlayerCubit songPlayerCubit;

  ReleaseDateSongsCubit(this.songPlayerCubit)
      : super(ReleaseDateSongsLoading());

  Future<void> releaseDateSongs(
      {required Timestamp startDate, required Timestamp endDate}) async {
    final params =
        GetReleaseDateSongsParams(startDate: startDate, endDate: endDate);
    var returnedSongs =
        await sl<GetReleaseDateSongsUseCase>().call(params: params);
    returnedSongs.fold(
      (failure) {
        emit(
          ReleaseDateSongsFailure(
              'Failed to get list of releaae date songs: $failure'),
        );
      },
      (data) {
        emit(
          ReleaseDateSongsLoaded(songs: data),
        );
      },
    );
  }

  void onSongTap({int? index, String? namePlaylist}) {
    final currentState = state;

    final currentNamePlaylist = namePlaylist!;

    if (currentState is ReleaseDateSongsLoaded) {
      final songs = currentState.songs;
      songPlayerCubit.updateSongs(songs, currentNamePlaylist);
      songPlayerCubit.switchPlaylist(currentNamePlaylist);
      if (index == null || index < 0 || index >= songs.length) {
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
