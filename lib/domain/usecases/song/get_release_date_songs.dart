import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecases/global_usecase.dart';
import 'package:spotify_clone/domain/repositories/song/song_repositories.dart';
import '../../../service_locator.dart';

class GetReleaseDateSongsUseCase
    implements UseCase<Either<dynamic, dynamic>, GetReleaseDateSongsParams> {
  @override
  Future<Either<dynamic, dynamic>> call(
      {GetReleaseDateSongsParams? params}) async {
    if (params == null) {
      return const Left('Parameters cannot be null');
    }
    return await sl<SongRepository>()
        .getereleaseDateSongs(params.startDate, params.endDate);
  }
}

class GetReleaseDateSongsParams {
  final Timestamp startDate;
  final Timestamp endDate;

  GetReleaseDateSongsParams({required this.startDate, required this.endDate});
}
