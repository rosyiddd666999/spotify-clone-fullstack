part of 'search_song_cubit.dart';

abstract class SearchSongState {}

class SearchSongInitial extends SearchSongState {}

class SearchSongLoading extends SearchSongState {}

class SearchSongSuggestionsLoaded extends SearchSongState {
  final List<SongEntity> song;

  SearchSongSuggestionsLoaded({required this.song});
}

class SearchSongResultsLoaded extends SearchSongState {
  final List<SongEntity> song;

  SearchSongResultsLoaded({required this.song});
}

class SearchSongFailure extends SearchSongState {
  final String message;

  SearchSongFailure(this.message);
}
