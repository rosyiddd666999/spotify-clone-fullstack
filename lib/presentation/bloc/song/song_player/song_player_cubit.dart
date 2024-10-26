import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../../../../core/configs/constans/app_urls.dart';
import '../../../../domain/entities/song/song_entity.dart';

part 'song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  final AudioPlayer audioPlayer;

  final Map<String, List<SongEntity>> playlists = {};
  final Map<String, int> currentIndices = {};
  String? currentPlaylist;

  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongEntity? currentlyPlayingSong;

  SongPlayerCubit({required this.audioPlayer}) : super(SongPlayerLoading()) {
    _setupListeners();
  }

  void updateSongs(List<SongEntity> newSongs, String playlistName) {
    playlists[playlistName] = newSongs;
    currentIndices[playlistName] = 0;

    if (currentPlaylist == null) {
      currentPlaylist = playlistName;
      loadSong();
    }
  }

  void _setupListeners() {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration ?? Duration.zero;
      updateSongPlayer();
    });

    audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        playNextSong();
      }
    });
  }

  void updateSongPlayer() {
    if (currentPlaylist != null && playlists[currentPlaylist!] != null) {
      emit(SongPlayerLoaded(
        songs: playlists[currentPlaylist!]!,
        currentIndex: currentIndices[currentPlaylist!]!,
        songPosition: songPosition,
        songDuration: songDuration,
        currentlyPlayingSong: currentlyPlayingSong!,
      ));
    }
  }

  Future<void> loadSong({int? index}) async {
    if (currentPlaylist == null || playlists[currentPlaylist!] == null) {
      emit(SongPlayerFailure('No songs available'));
      return;
    }

    final songs = playlists[currentPlaylist!]!;
    if (index != null && index < songs.length) {
      currentIndices[currentPlaylist!] = index;
    }

    final currentIndex = currentIndices[currentPlaylist!]!;
    final song = songs[currentIndex];
    currentlyPlayingSong = song;

    String songArtist = Uri.encodeComponent(song.artist);
    String songTitle = Uri.encodeComponent(song.title);

    final url =
        "${AppURLs.songFirestorage}$songArtist - $songTitle.mp3?${AppURLs.mediaAlt}";

    try {
      await audioPlayer.setAudioSource(AudioSource.uri(
        Uri.parse(url),
        tag: MediaItem(
          id: song.songId,
          album: "Spotify Clone",
          title: song.title,
          artist: song.artist,
          artUri: Uri.parse(
            '${AppURLs.coverFirestorage}${song.artist} - ${song.title}.jpg?${AppURLs.mediaAlt}',
          ),
        ),
      ));
      audioPlayer.play();
      updateSongPlayer();
    } catch (e) {
      emit(SongPlayerFailure(e.toString()));
    }
  }

  void playOrPauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    updateSongPlayer();
  }

  void playNextSong() {
    final songs = playlists[currentPlaylist!]!;
    if (currentIndices[currentPlaylist!]! < songs.length - 1) {
      currentIndices[currentPlaylist!] = currentIndices[currentPlaylist!]! + 1;
      loadSong();
    } else {
      emit(SongPlayerFailure('No more songs in the playlist'));
    }
  }

  void playPreviousSong() {
    if (currentIndices[currentPlaylist!]! > 0) {
      currentIndices[currentPlaylist!] = currentIndices[currentPlaylist!]! - 1;
      loadSong();
    } else {
      emit(SongPlayerFailure('No previous song in the playlist'));
    }
  }

  void jumpToSong({int? index}) {
    final songs = playlists[currentPlaylist!]!;

    if (index == null || index >= songs.length || index < 0) {
      index = Random().nextInt(songs.length);
    }

    loadSong(index: index);
  }

  void switchPlaylist(String playlistName) {
    if (playlists.containsKey(playlistName)) {
      currentPlaylist = playlistName;
      updateSongPlayer();
    } else {
      emit(SongPlayerFailure('Playlist not found'));
    }
  }
}
