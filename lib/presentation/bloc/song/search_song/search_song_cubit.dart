import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/entities/song/song_entity.dart';
import 'package:spotify_clone/domain/usecases/song/searh_song.dart';
import 'package:spotify_clone/presentation/bloc/song/song_player/song_player_cubit.dart';

import '../../../../service_locator.dart';
part 'search_song_state.dart';

class SearchSongCubit extends Cubit<SearchSongState> {
  final SongPlayerCubit songPlayerCubit;

  SearchSongCubit(this.songPlayerCubit) : super(SearchSongInitial());

  Future<void> searchSong(String query) async {
    if (query.isEmpty) {
      emit(SearchSongFailure('Failed to get list of search songs: $query'));
      return;
    }
    emit(SearchSongLoading());

    var returnedSong = await sl<SearchSongUseCase>().call(params: query);
    returnedSong.fold(
      (failure) {
        emit(SearchSongFailure('Failed to get list of search songs: $failure'));
      },
      (data) {
        emit(SearchSongResultsLoaded(song: data));
      },
    );
  }

  Future<void> fetchSuggestions(String query) async {
    if (query.isEmpty) {
      emit(SearchSongInitial());
      return;
    }

    var returnedSong = await sl<SearchSongUseCase>().call(params: query);
    returnedSong.fold(
      (failure) {
        emit(SearchSongFailure('Failed to get list of search songs: $failure'));
      },
      (data) {
        emit(SearchSongSuggestionsLoaded(song: data));
      },
    );
  }

  void clearSearch() {
    emit(SearchSongInitial());
  }

  void onSongTap({int? index, String? namePlaylist}) {
    final currentState = state;
    final currentNamePlaylist = namePlaylist!;

    if (currentState is SearchSongResultsLoaded) {
      final songs = currentState.song;
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
