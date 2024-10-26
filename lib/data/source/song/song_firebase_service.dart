import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_clone/data/models/song/song.dart';
import 'package:spotify_clone/domain/entities/song/song_entity.dart';

import '../../../domain/usecases/song/is_favorite_song.dart';
import '../../../service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> geteReleaseDateSongs(Timestamp startDate, Timestamp endDate);
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavoriteSongs(String songId);
  Future<bool> isFavoriteSongs(String songId);
  Future<Either> getUserFavoriteSongs();
  Future<Either> searchSongs(String query);
  Future<Either> getArtistSongs(String artist);
  Future<Either> getGenresSongs(List<String> genres);
  Future<Either> getActivityTypeSongs(List<String> activityType);
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate')
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>()
            .call(params: element.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return Left('An error occurred$e, Please try again.');
    }
  }

  @override
  Future<Either> geteReleaseDateSongs(
      Timestamp startDate, Timestamp endDate) async {
    try {
      List<SongEntity> songs = [];
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var data = await firebaseFirestore
          .collection('Songs')
          .where('releaseDate', isGreaterThanOrEqualTo: startDate)
          .where('releaseDate', isLessThanOrEqualTo: endDate)
          .orderBy('releaseDate')
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>()
            .call(params: element.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return Left('An error occurred$e, Please try again.');
    }
  }

  @override
  Future<Either> getGenresSongs(List<String> genres) async {
    try {
      List<SongEntity> songs = [];
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var data = await firebaseFirestore
          .collection('Songs')
          .where('genres', arrayContainsAny: genres)
          .get();

      for (var element in data.docs) {
        try {
          var songModel = SongModel.fromJson(element.data());
          bool isFavorite = await sl<IsFavoriteSongUseCase>()
              .call(params: element.reference.id);
          songModel.isFavorite = isFavorite;
          songModel.songId = element.reference.id;
          songs.add(songModel.toEntity());
        } catch (e) {
          // ignore: avoid_print
          print('Error processing song: $e');
        }
      }

      return Right(songs);
    } catch (e) {
      return Left('An error occurred$e, Please try again.');
    }
  }

  @override
  Future<Either> getArtistSongs(String artist) async {
    try {
      List<SongEntity> songs = [];
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var data = await firebaseFirestore
          .collection('Songs')
          .where('artist', isEqualTo: artist)
          .get();

      for (var element in data.docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await sl<IsFavoriteSongUseCase>()
            .call(params: element.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return Left('An error occurred$e, Please try again.');
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      late bool isFavoriteSongs;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('FavoritesSongs')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
        isFavoriteSongs = false;
      } else {
        await firebaseFirestore
            .collection('Users')
            .doc(uId)
            .collection('FavoritesSongs')
            .add({'songId': songId, 'addedDate': Timestamp.now()});
        isFavoriteSongs = true;
      }

      return Right(isFavoriteSongs);
    } catch (e) {
      return const Left('An error occurred');
    }
  }

  @override
  Future<bool> isFavoriteSongs(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('FavoritesSongs')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSongs.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either> getUserFavoriteSongs() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = firebaseAuth.currentUser;
      List<SongEntity> favoriteSongs = [];
      String uId = user!.uid;
      QuerySnapshot favoritesSnapshot = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('FavoritesSongs')
          .get();

      for (var element in favoritesSnapshot.docs) {
        String songId = element['songId'];
        var song =
            await firebaseFirestore.collection('Songs').doc(songId).get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavorite = true;
        songModel.songId = songId;
        favoriteSongs.add(songModel.toEntity());
      }

      return Right(favoriteSongs);
    } catch (e) {
      return const Left('An error occurred');
    }
  }

  @override
  Future<Either<String, List<SongEntity>>> searchSongs(String query) async {
    try {
      List<SongEntity> songs = [];
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      query = query.toLowerCase();

      QuerySnapshot titleSongSnapshot = await firebaseFirestore
          .collection('Songs')
          .orderBy('title')
          .startAt([query]).endAt(['$query\uf8ff']).get();

      QuerySnapshot artistSongSnapshot = await firebaseFirestore
          .collection('Songs')
          .orderBy('artist')
          .startAt([query]).endAt(['$query\uf8ff']).get();

      var combinedDocs = {
        ...titleSongSnapshot.docs,
        ...artistSongSnapshot.docs
      };

      for (var element in combinedDocs) {
        var songModel =
            SongModel.fromJson(element.data() as Map<String, dynamic>);
        bool isFavorite =
            await sl<IsFavoriteSongUseCase>().call(params: element.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = element.id;
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return const Left('An error occurred, Please try again.');
    }
  }

  @override
  Future<Either> getActivityTypeSongs(List<String> activityType) async {
    try {
      List<SongEntity> songs = [];
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var data = await firebaseFirestore
          .collection('Songs')
          .where('activityType', arrayContainsAny: activityType)
          .get();

      for (var element in data.docs) {
        try {
          var songModel = SongModel.fromJson(element.data());
          bool isFavorite = await sl<IsFavoriteSongUseCase>()
              .call(params: element.reference.id);
          songModel.isFavorite = isFavorite;
          songModel.songId = element.reference.id;
          songs.add(songModel.toEntity());
        } catch (e) {
          // ignore: avoid_print
          print('Error processing song: $e');
        }
      }

      return Right(songs);
    } catch (e) {
      return Left('An error occurred$e, Please try again.');
    }
  }
}
