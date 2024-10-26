part of 'release_date_songs_cubit.dart';

@immutable
sealed class ReleaseDateSongsState {}

final class ReleaseDateSongsLoading extends ReleaseDateSongsState {}

final class ReleaseDateSongsLoaded extends ReleaseDateSongsState {
  final List<SongEntity> songs;

  ReleaseDateSongsLoaded({required this.songs});
}

final class ReleaseDateSongsFailure extends ReleaseDateSongsState {
  final String message;

  ReleaseDateSongsFailure(this.message);
}
