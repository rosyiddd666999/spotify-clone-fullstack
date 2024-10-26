import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/presentation/widgets/home/something_else.dart';
import 'package:spotify_clone/presentation/widgets/home/top_genres_mix.dart';
import '../../bloc/tabs/tabs_home_cubit.dart';
import '../../widgets/home/best_of_artist.dart';
import '../../widgets/home/get_started.dart';
import '../../widgets/home/home_header.dart';
import '../../widgets/my_drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: const MyDrawer(),
        body: BlocBuilder<TabsHomeCubit, int>(
          builder: (context, state) {
            return DefaultTabController(
              length: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  HomeHeader(
                    onTapDrawer: () {
                      scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                  Expanded(
                    child: allSongs(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget allSongs() {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, bottom: 18, top: 16),
            child: Text(
              'To get you started',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
            ),
          ),
          SizedBox(
            height: 200,
            child: GetStarted(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, bottom: 18, top: 20),
            child: Text(
              'Try something else',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
            ),
          ),
          SizedBox(
            height: 200,
            child: SomethingElse(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, bottom: 18, top: 20),
            child: Text(
              'Best of Artist',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
            ),
          ),
          SizedBox(
            height: 200,
            child: BestOfArtist(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, bottom: 18, top: 20),
            child: Text(
              'Top genres mix',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
            ),
          ),
          SizedBox(
            height: 200,
            child: TopGenresMix(),
          ),
        ],
      ),
    );
  }
}
