import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/presentation/bloc/song/song_player/song_player_cubit.dart';
import 'package:spotify_clone/presentation/widgets/global_components/song_item_list.dart';

import '../../bloc/song/search_song/search_song_cubit.dart';
import 'package:spotify_clone/domain/entities/song/song_entity.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _searchTextField(context),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<SearchSongCubit, SearchSongState>(
                      builder: (context, state) {
                        if (state is SearchSongLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is SearchSongFailure) {
                          return const Center(
                              child: Text('Failed to load songs'));
                        } else if (state is SearchSongResultsLoaded) {
                          if (state.song.isEmpty) {
                            return const Center(child: Text('No songs found'));
                          }
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 20),
                              itemCount: state.song.length,
                              itemBuilder: (context, index) {
                                final song = state.song[index];
                                return GestureDetector(
                                  onTap: () {
                                    context.read<SearchSongCubit>().onSongTap(
                                        index: index,
                                        namePlaylist: 'SearchSongResults');
                                    context
                                        .read<SongPlayerCubit>()
                                        .jumpToSong(index: index);
                                  },
                                  child: SongItemList(
                                    songEntity: song,
                                    currentIndex: index,
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(40.0),
                            child: Text('Search for songs'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchTextField(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: (query) {
              if (query.isNotEmpty) {
                context.read<SearchSongCubit>().fetchSuggestions(query);
              } else {
                context.read<SearchSongCubit>().clearSearch();
              }
            },
            onSubmitted: (query) {
              if (query.isNotEmpty) {
                context.read<SearchSongCubit>().searchSong(query);
              } else {
                context.read<SearchSongCubit>().clearSearch();
              }
            },
            decoration: InputDecoration(
              prefixIcon: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                ),
              ),
              contentPadding: const EdgeInsets.all(16),
              hintText: 'Search here...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: Colors.white24,
            ),
          ),
          BlocBuilder<SearchSongCubit, SearchSongState>(
            builder: (context, state) {
              if (state is SearchSongSuggestionsLoaded &&
                  searchController.text.isNotEmpty) {
                return ListSuggestions(
                  searchController: searchController,
                  suggestions: state.song,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class ListSuggestions extends StatelessWidget {
  const ListSuggestions({
    super.key,
    required this.searchController,
    required this.suggestions,
  });

  final TextEditingController searchController;
  final List<SongEntity> suggestions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final song = suggestions[index];
        return ListTile(
          title: Text(song.title),
          onTap: () {
            searchController.text = song.title;
            context.read<SearchSongCubit>().searchSong(song.title);
          },
        );
      },
    );
  }
}
