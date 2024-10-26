import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/domain/entities/song/song_entity.dart';
import 'package:spotify_clone/domain/usecases/song/get_activity_type.dart';
import 'package:spotify_clone/presentation/bloc/song/song_player/song_player_cubit.dart';
import 'package:spotify_clone/service_locator.dart';

part 'activity_type_state.dart';

class ActivityTypeCubit extends Cubit<ActivityTypeState> {
  final SongPlayerCubit songPlayerCubit;

  ActivityTypeCubit(this.songPlayerCubit) : super(ActivityTypeLoading());

  Future<void> activityTypeSongs(List<String> activityType) async {
    var returnedSongs =
        await sl<GetActivityTypeSongsUseCase>().call(params: activityType);
    returnedSongs.fold(
      (failure) {
        emit(
          ActivityTypeFailure('Failed to get list of genres songs: $failure'),
        );
      },
      (data) {
        emit(
          ActivityTypeLoaded(songs: data),
        );
      },
    );
  }

  void onSongTap({int? index, String? namePlaylist}) {
    final currentState = state;
    final currentNamePlaylist = namePlaylist!;
    if (currentState is ActivityTypeLoaded) {
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
