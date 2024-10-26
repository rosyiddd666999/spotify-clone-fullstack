abstract class FavoriteButtonSongState {}

class FavoriteButtonSongInitial extends FavoriteButtonSongState {}

class FavoriteButtonSongUpdated extends FavoriteButtonSongState {
  final bool isFavoriteSongs;

  FavoriteButtonSongUpdated({required this.isFavoriteSongs});
}
