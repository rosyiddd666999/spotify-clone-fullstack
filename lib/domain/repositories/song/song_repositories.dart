import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class SongRepository {
  Future<Either> getPlayList();
  Future<Either> getereleaseDateSongs(Timestamp startDate, Timestamp endDate);
  Future<Either> addOrRemoveFavoriteSongs(String songId);
  Future<bool> isFavoriteSongs(String songId);
  Future<Either> getUserFavoriteSongs();
  Future<Either> searchSongs(String query);
  Future<Either> getArtistSongs(String artist);
  Future<Either> getGenresSongs(List<String> genres);
  Future<Either> getActivityTypeSongs(List<String> activityType);
}
