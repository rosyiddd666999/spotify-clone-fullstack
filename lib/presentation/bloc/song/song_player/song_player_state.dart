part of 'song_player_cubit.dart';

abstract class SongPlayerState {}

class SongPlayerLoading extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {
  final List<SongEntity> songs;
  final Duration songPosition;
  final Duration songDuration;
  final int currentIndex;
  final SongEntity currentlyPlayingSong;

  SongPlayerLoaded(
      {required this.songs,
      required this.currentIndex,
      required this.songDuration,
      required this.songPosition,
      required this.currentlyPlayingSong});
}

class SongPlayerFailure extends SongPlayerState {
  final String message;
  SongPlayerFailure(this.message);
}
