import '../../../core/usecases/global_usecase.dart';
import '../../../service_locator.dart';
import '../../repositories/song/song_repositories.dart';

class IsFavoriteSongUseCase implements UseCase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongRepository>().isFavoriteSongs(params!);
  }
}
