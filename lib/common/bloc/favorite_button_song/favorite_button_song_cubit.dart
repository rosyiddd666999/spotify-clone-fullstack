import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/song/add_or_remove_favorite_song.dart';
import '../../../service_locator.dart';
import 'favorite_button_song_state.dart';

class FavoriteButtonSongCubit extends Cubit<FavoriteButtonSongState> {
  FavoriteButtonSongCubit() : super(FavoriteButtonSongInitial());

  Future<void> favoriteButtonSongUpdated(String songId) async {
    var result =
        await sl<AddOrRemoveFavoriteSongUseCase>().call(params: songId);
    result.fold(
      (failure) {},
      (isFavoriteSongs) {
        emit(FavoriteButtonSongUpdated(isFavoriteSongs: isFavoriteSongs));
      },
    );
  }
}
