import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify_clone/domain/repositories/song/song_repositories.dart';

import '../../../service_locator.dart';
import '../../source/song/song_firebase_service.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> getPlayList() async {
    return await sl<SongFirebaseService>().getPlayList();
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    return await sl<SongFirebaseService>().addOrRemoveFavoriteSongs(songId);
  }

  @override
  Future<bool> isFavoriteSongs(String songId) async {
    return await sl<SongFirebaseService>().isFavoriteSongs(songId);
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    return await sl<SongFirebaseService>().getUserFavoriteSongs();
  }

  @override
  Future<Either> searchSongs(String query) async {
    return await sl<SongFirebaseService>().searchSongs(query);
  }

  @override
  Future<Either> getereleaseDateSongs(
      Timestamp startDate, Timestamp endDate) async {
    return await sl<SongFirebaseService>()
        .geteReleaseDateSongs(startDate, endDate);
  }

  @override
  Future<Either> getArtistSongs(String artist) async {
    return await sl<SongFirebaseService>().getArtistSongs(artist);
  }

  @override
  Future<Either> getGenresSongs(List<String> genres) async {
    return await sl<SongFirebaseService>().getGenresSongs(genres);
  }

  @override
  Future<Either> getActivityTypeSongs(List<String> activityType) async {
    return await sl<SongFirebaseService>().getActivityTypeSongs(activityType);
  }
}
