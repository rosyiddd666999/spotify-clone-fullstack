import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecases/global_usecase.dart';
import 'package:spotify_clone/domain/repositories/song/song_repositories.dart';
import 'package:spotify_clone/service_locator.dart';

class GetActivityTypeSongsUseCase implements UseCase<Either, List<String>> {
  @override
  Future<Either> call({List<String>? params}) async {
    return await sl<SongRepository>().getActivityTypeSongs(params!);
  }
}
