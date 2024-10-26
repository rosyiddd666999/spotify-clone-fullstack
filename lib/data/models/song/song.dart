import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/song/song_entity.dart';

class SongModel {
  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseDate;
  bool? isFavorite;
  String? songId;
  List<String>? genres;
  List<String>? activityType;

  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavorite,
    required this.songId,
    required this.genres,
    required this.activityType,
  });

  SongModel.fromJson(
    Map<String, dynamic> data,
  ) {
    songId = data['songId'] is String ? data['songId'] : '';
    title = data['title'] is String ? data['title'] : '';
    artist = data['artist'] is String ? data['artist'] : '';
    duration = data['duration'] is num ? data['duration'] : 0;
    releaseDate = data['releaseDate'] is Timestamp
        ? data['releaseDate']
        : Timestamp.now();
    genres = data['genres'] is List ? List<String>.from(data['genres']) : [];
    activityType = data['activityType'] is List
        ? List<String>.from(data['activityType'])
        : [];
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title ?? 'Unknown Title',
      artist: artist ?? 'Unknown Artist',
      duration: duration ?? 0,
      releaseDate: releaseDate ?? Timestamp.now(),
      isFavorite: isFavorite ?? false,
      songId: songId ?? '',
      genres: genres ?? [],
      activityType: activityType ?? [],
    );
  }
}
