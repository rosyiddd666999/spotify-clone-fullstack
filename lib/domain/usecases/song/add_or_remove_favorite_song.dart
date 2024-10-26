import 'package:dartz/dartz.dart';

import '../../../core/usecases/global_usecase.dart';
import '../../../service_locator.dart';
import '../../repositories/song/song_repositories.dart';

class AddOrRemoveFavoriteSongUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongRepository>().addOrRemoveFavoriteSongs(params!);
  }
}
