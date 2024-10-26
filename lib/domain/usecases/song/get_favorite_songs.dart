import 'package:dartz/dartz.dart';

import '../../../core/usecases/global_usecase.dart';
import '../../../service_locator.dart';
import '../../repositories/song/song_repositories.dart';

class GetFavoriteSongsUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return await sl<SongRepository>().getUserFavoriteSongs();
  }
}
