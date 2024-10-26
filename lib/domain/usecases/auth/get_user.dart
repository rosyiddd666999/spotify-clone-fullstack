import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecases/global_usecase.dart';
import 'package:spotify_clone/service_locator.dart';

import '../../repositories/auth/auth_repositories.dart';

class GetUserUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) {
    return sl<AuthRepository>().getUser();
  }
}
