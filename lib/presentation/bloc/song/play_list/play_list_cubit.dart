import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/presentation/bloc/song/song_player/song_player_cubit.dart';

import '../../../../domain/entities/song/song_entity.dart';
import '../../../../domain/usecases/song/get_play_list.dart';
import '../../../../service_locator.dart';

part 'play_list_state.dart';

class PlayListCubit extends Cubit<PlayListState> {
  final SongPlayerCubit songPlayerCubit;

  PlayListCubit(this.songPlayerCubit) : super(PlayListLoading());

  Future<void> getPlayList() async {
    var returnedSongs = await sl<GetPlayListUseCase>().call();
    returnedSongs.fold((failure) {
      emit(
        PlayListFailure('Failed to get list of playlist songs: $failure'),
      );
    }, (data) {
      emit(
        PlayListLoaded(songs: data),
      );
    });
  }

  void onSongTap({int? index, String? namePlaylist}) {
    final currentState = state;
    final currentNamePlaylist = namePlaylist!;

    if (currentState is PlayListLoaded) {
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
