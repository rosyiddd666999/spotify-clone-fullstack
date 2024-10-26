import 'package:flutter/material.dart';
import 'package:spotify_clone/presentation/widgets/search/start_browsing_gv.dart';
import '../../widgets/global_components/user_avatar_image.dart';
import '../../widgets/my_drawer.dart';
import '../../widgets/search/browse_all_gv.dart';
import '../../widgets/search/search_text_field.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: const MyDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchHeader(context),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 16, top: 10, bottom: 10),
                            child: Text(
                              'Start browsing',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          _startBrowsing(context),
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 16, top: 10, bottom: 10),
                            child: Text(
                              'Browse all',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          _browseAll(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _startBrowsing(BuildContext context) {
    return const StartBrowsingGridView();
  }

  Widget _browseAll(BuildContext context) {
    return const BrowseAlGridView();
  }

  Widget _searchHeader(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            UserAvatarImage(scaffoldKey: scaffoldKey),
            const SizedBox(
              width: 16,
            ),
            const Text(
              'Search',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const SearchTextField(),
      ],
    );
  }
}
