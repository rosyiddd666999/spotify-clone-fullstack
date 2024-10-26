import 'package:flutter/material.dart';
import 'package:spotify_clone/core/routes/routes.dart';
import 'package:spotify_clone/presentation/bloc/song/activity_type/activity_type_cubit.dart';
import 'package:spotify_clone/presentation/bloc/song/artist_songs/artist_songs_cubit.dart';
import 'package:spotify_clone/presentation/bloc/song/genres_songs/genres_songs_cubit.dart';
import 'package:spotify_clone/presentation/bloc/song/release_date_songs.dart/release_date_songs_cubit.dart';
import 'package:spotify_clone/presentation/bloc/song/play_list/play_list_cubit.dart';
import 'package:spotify_clone/presentation/bloc/tabs/tabs_library_cubit.dart';
import 'main.dart';
import 'presentation/bloc/profile_info/profile_info_cubit.dart';
import 'presentation/bloc/song/favorite_song/favorite_song_cubit.dart';
import 'presentation/bloc/song/song_player/song_player_cubit.dart';
import 'presentation/bloc/theme/theme_cubit.dart';
import 'package:spotify_clone/presentation/bloc/song/search_song/search_song_cubit.dart';
import 'package:spotify_clone/presentation/bloc/tabs/tabs_bn_cubit.dart';
import 'package:spotify_clone/presentation/bloc/tabs/tabs_home_cubit.dart';
import 'core/configs/themes/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SongPlayerCubit(
            audioPlayer: AudioPlayerSingleton.instance,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeCubit(),
          ),
          BlocProvider(
            create: (context) => ProfileInfoCubit()..getUser(),
          ),
          BlocProvider(
            create: (context) => TabsHomeCubit(),
          ),
          BlocProvider(
            create: (context) => TabsLibraryCubit(),
          ),
          BlocProvider(
            create: (context) => TabsBottomNavCubit(),
          ),
          BlocProvider(
            create: (context) =>
                SearchSongCubit(context.read<SongPlayerCubit>()),
          ),
          BlocProvider(
            create: (context) => FavoriteSongsCubit(
              context.read<SongPlayerCubit>(),
            )..getFavoriteSongs(),
          ),
          BlocProvider(
            create: (context) => ReleaseDateSongsCubit(
              context.read<SongPlayerCubit>(),
            ),
          ),
          BlocProvider(
            create: (context) => ArtistSongsCubit(
              context.read<SongPlayerCubit>(),
            ),
          ),
          BlocProvider(
              create: (context) => GenresSongsCubit(
                    context.read<SongPlayerCubit>(),
                  )),
          BlocProvider(
            create: (context) => PlayListCubit(
              context.read<SongPlayerCubit>(),
            )..getPlayList(),
          ),
          BlocProvider(
            create: (context) => ActivityTypeCubit(
              context.read<SongPlayerCubit>(),
            ),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, mode) => MaterialApp.router(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: mode,
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          ),
        ),
      ),
    );
  }
}
