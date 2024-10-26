import 'package:get_it/get_it.dart';
import 'package:spotify_clone/data/repositories/auth/auth_repositories_impl.dart';
import 'package:spotify_clone/data/repositories/song/song_repositories_impl.dart';
import 'package:spotify_clone/data/source/auth/auth_firebase_service.dart';
import 'package:spotify_clone/data/source/song/song_firebase_service.dart';
import 'package:spotify_clone/domain/repositories/auth/auth_repositories.dart';
import 'package:spotify_clone/domain/repositories/song/song_repositories.dart';
import 'package:spotify_clone/domain/usecases/auth/get_user.dart';
import 'package:spotify_clone/domain/usecases/auth/signup.dart';
import 'package:spotify_clone/domain/usecases/song/get_activity_type.dart';
import 'package:spotify_clone/domain/usecases/song/get_release_date_songs.dart';
import 'package:spotify_clone/domain/usecases/song/get_artist_songs.dart';
import 'package:spotify_clone/domain/usecases/song/get_genres_songs.dart';
import 'package:spotify_clone/domain/usecases/song/searh_song.dart';

import 'domain/usecases/auth/signin.dart';
import 'domain/usecases/song/add_or_remove_favorite_song.dart';
import 'domain/usecases/song/get_favorite_songs.dart';
import 'domain/usecases/song/get_play_list.dart';
import 'domain/usecases/song/is_favorite_song.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  //sevice
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());

  //repo
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SongRepository>(SongRepositoryImpl());

  //user usecase
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());

  sl.registerSingleton<SignInUseCase>(SignInUseCase());

  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  //song usecase
  sl.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());

  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
      AddOrRemoveFavoriteSongUseCase());

  sl.registerSingleton<IsFavoriteSongUseCase>(IsFavoriteSongUseCase());

  sl.registerSingleton<GetFavoriteSongsUseCase>(GetFavoriteSongsUseCase());

  sl.registerSingleton<SearchSongUseCase>(SearchSongUseCase());

  sl.registerSingleton<GetReleaseDateSongsUseCase>(
      GetReleaseDateSongsUseCase());

  sl.registerSingleton<GetArtistSongsUseCase>(GetArtistSongsUseCase());

  sl.registerSingleton<GetGenresSongsUseCase>(GetGenresSongsUseCase());

  sl.registerSingleton<GetActivityTypeSongsUseCase>(
      GetActivityTypeSongsUseCase());
}
