import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecases/global_usecase.dart';
import 'package:spotify_clone/data/models/auth/sign_in_user.dart';
import 'package:spotify_clone/domain/repositories/auth/auth_repositories.dart';

import '../../../service_locator.dart';

class SignInUseCase extends UseCase<Either, SignInUserReq> {
  @override
  Future<Either> call({SignInUserReq? params}) async {
    return sl<AuthRepository>().signIn(params!);
  }
}
