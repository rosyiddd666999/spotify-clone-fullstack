part of 'activity_type_cubit.dart';

sealed class ActivityTypeState {}

final class ActivityTypeLoading extends ActivityTypeState {}

final class ActivityTypeLoaded extends ActivityTypeState {
  final List<SongEntity> songs;

  ActivityTypeLoaded({required this.songs});
}

final class ActivityTypeFailure extends ActivityTypeState {
  final String message;

  ActivityTypeFailure(this.message);
}
