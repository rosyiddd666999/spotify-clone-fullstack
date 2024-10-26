part of 'genres_songs_cubit.dart';

@immutable
sealed class GenresSongsState {}

final class GenresSongsLoading extends GenresSongsState {}

final class GenresSongsLoaded extends GenresSongsState {
  final List<SongEntity> songs;

  GenresSongsLoaded({required this.songs});
}

final class GenresSongsFailure extends GenresSongsState {
  final String message;

  GenresSongsFailure(this.message);
}
