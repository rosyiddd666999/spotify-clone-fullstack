import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/presentation/pages/auth/signup_or_signin.dart';
import 'package:spotify_clone/presentation/pages/search/search.dart';
import 'package:spotify_clone/presentation/pages/library/library.dart';
import 'package:spotify_clone/presentation/pages/home/home.dart';
import 'package:spotify_clone/presentation/pages/profile/profile.dart';
import 'package:spotify_clone/presentation/pages/song_playlist/activity_type.dart';
import 'package:spotify_clone/presentation/pages/song_playlist/all_music.dart';
import 'package:spotify_clone/presentation/widgets/bottom_dashboard.dart';
import 'package:spotify_clone/presentation/pages/song_playlist/artist.dart';
import 'package:spotify_clone/presentation/pages/song_playlist/genres.dart';
import 'package:spotify_clone/presentation/pages/song_playlist/release_date.dart';

import '../../presentation/pages/auth/signin.dart';
import '../../presentation/pages/auth/signup.dart';
import '../../presentation/pages/song_playlist/like_music.dart';

part 'routes_name.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  redirect: (context, state) {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final isGoingToAuthPages = state.matchedLocation == '/signUpOrsignIn' ||
        state.matchedLocation == '/signUpOrsignIn/signUp' ||
        state.matchedLocation == '/signUpOrsignIn/signIn';
    if (firebaseAuth.currentUser == null && !isGoingToAuthPages) {
      return "/signUpOrsignIn";
    } else {
      return null;
    }
  },
  navigatorKey: _shellNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) {
        return MyDashboard(
          shell: shell,
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _rootNavigatorKey,
          routes: [
            GoRoute(
              path: '/',
              name: Routes.home,
              builder: (context, state) => HomePage(),
              routes: [
                GoRoute(
                  path: 'artist/:artist/:nameArtistPlaylist',
                  name: Routes.artistName,
                  builder: (context, state) {
                    final artistNames =
                        state.pathParameters['artist']!.split(', ');
                    final nameArtistPlaylist =
                        state.pathParameters['nameArtistPlaylist'];
                    return ArtistMixPage(
                      artistNames: artistNames,
                      namePlaylist: nameArtistPlaylist!,
                    );
                  },
                ),
                GoRoute(
                  path: 'releaseDateHome/:startDate/:endDate/:nameRDPlaylist',
                  name: Routes.releaseDateHome,
                  builder: (context, state) {
                    final nameRDPlaylist =
                        state.pathParameters['nameRDPlaylist'];
                    final startDateStr = state.pathParameters['startDate']!;
                    final endDateStr = state.pathParameters['endDate']!;

                    final startDate =
                        Timestamp.fromDate(DateTime.parse(startDateStr));
                    final endDate =
                        Timestamp.fromDate(DateTime.parse(endDateStr));

                    return ReleaseDatePage(
                      startDate: startDate,
                      endDate: endDate,
                      namePlaylist: nameRDPlaylist!,
                    );
                  },
                ),
                GoRoute(
                  path: 'genres/:genres/:nameGenresPlaylist',
                  name: Routes.genresHome,
                  builder: (context, state) {
                    final nameGenresPlaylist =
                        state.pathParameters['nameGenresPlaylist'];
                    final genresParam = state.pathParameters['genres']!;
                    final List<String> genres = genresParam.split(',');

                    return GenresSongsPage(
                      genres: genres,
                      namePlaylist: nameGenresPlaylist!,
                    );
                  },
                ),
                GoRoute(
                  path: 'activityType/:activityType',
                  name: Routes.activityTypeHome,
                  builder: (context, state) {
                    final acvitityTypeParam =
                        state.pathParameters['activityType']!;
                    final List<String> activityType =
                        acvitityTypeParam.split(',');

                    return ActivityTypeSongsPage(activityType: activityType);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              name: Routes.search,
              builder: (context, state) => SearchPage(),
              routes: [
                GoRoute(
                  path: 'playlist',
                  name: Routes.allMusic,
                  builder: (context, state) => const ALlMusicPage(),
                ),
                GoRoute(
                  path: 'releaseDateSearch/:startDate/:endDate/:nameRDPlaylist',
                  name: Routes.releaseDateSearch,
                  builder: (context, state) {
                    final nameRDPlaylist =
                        state.pathParameters['nameRDPlaylist'];
                    final startDateStr = state.pathParameters['startDate']!;
                    final endDateStr = state.pathParameters['endDate']!;

                    final startDate =
                        Timestamp.fromDate(DateTime.parse(startDateStr));
                    final endDate =
                        Timestamp.fromDate(DateTime.parse(endDateStr));

                    return ReleaseDatePage(
                      startDate: startDate,
                      endDate: endDate,
                      namePlaylist: nameRDPlaylist!,
                    );
                  },
                  // routes: [
                  //   GoRoute(
                  //     parentNavigatorKey: _shellNavigatorKey,
                  //     path: ':songsId',
                  //     name: Routes.y10Until20SongPlayer,
                  //     builder: (context, state) {
                  //       final songs = state.extra as List<SongEntity>;
                  //       final songId = state.pathParameters['songsId'];
                  //       final initialIndexS =
                  //           songs.indexWhere((song) => song.songId == songId);
                  //       return SongPlayerPage(songs: songs, initialIndexS);
                  //     },
                  //   ),
                  // ],
                ),
                GoRoute(
                  path: 'artist/:artist/:nameArtistPlaylist',
                  name: Routes.artistSearch,
                  builder: (context, state) {
                    final artistNames =
                        state.pathParameters['artist']!.split(', ');

                    final nameArtistPlaylist =
                        state.pathParameters['nameArtistPlaylist'];
                    return ArtistMixPage(
                      artistNames: artistNames,
                      namePlaylist: nameArtistPlaylist!,
                    );
                  },
                ),
                GoRoute(
                  path: 'genres/:genres/:nameGenresPlaylist',
                  name: Routes.genresSearch,
                  builder: (context, state) {
                    final nameGenresPlaylist =
                        state.pathParameters['nameGenresPlaylist'];
                    final genresParam = state.pathParameters['genres']!;
                    final List<String> genres = genresParam.split(',');

                    return GenresSongsPage(
                      genres: genres,
                      namePlaylist: nameGenresPlaylist!,
                    );
                  },
                ),
                GoRoute(
                  path: 'activityType/:activityType',
                  name: Routes.activityTypeSearch,
                  builder: (context, state) {
                    final acvitityTypeParam =
                        state.pathParameters['activityType']!;
                    final List<String> acvitityType =
                        acvitityTypeParam.split(',');

                    return ActivityTypeSongsPage(activityType: acvitityType);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/collection',
              name: Routes.collection,
              builder: (context, state) => LibraryPage(),
              routes: [
                GoRoute(
                  path: 'likedSongs',
                  name: Routes.likedSongs,
                  builder: (context, state) => const LikedMusicPage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: Routes.profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/signUpOrsignIn',
      name: Routes.signUpOrsignIn,
      builder: (context, state) => const SignupOrSigninPage(),
      routes: [
        GoRoute(
          path: 'signUp',
          name: Routes.signUp,
          builder: (context, state) => SignupPage(),
        ),
        GoRoute(
          path: 'signIn',
          name: Routes.signIn,
          builder: (context, state) => SigninPage(),
        ),
      ],
    ),
  ],
);
