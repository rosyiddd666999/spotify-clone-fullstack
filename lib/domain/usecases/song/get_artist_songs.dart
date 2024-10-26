import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecases/global_usecase.dart';
import 'package:spotify_clone/domain/repositories/song/song_repositories.dart';

import '../../../service_locator.dart';

class GetArtistSongsUseCase implements UseCase<Either, String?> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongRepository>().getArtistSongs(params!);
  }
}
