part of 'play_list_cubit.dart';

abstract class PlayListState {}

class PlayListLoading extends PlayListState {}

class PlayListLoaded extends PlayListState {
  final List<SongEntity> songs;

  PlayListLoaded({required this.songs});
}

class PlayListFailure extends PlayListState {
  final String message;

  PlayListFailure(this.message);
}
