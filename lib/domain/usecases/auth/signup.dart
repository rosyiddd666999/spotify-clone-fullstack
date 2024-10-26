import 'package:dartz/dartz.dart';
import 'package:spotify_clone/core/usecases/global_usecase.dart';
import 'package:spotify_clone/data/models/auth/create_user.dart';
import 'package:spotify_clone/domain/repositories/auth/auth_repositories.dart';
import 'package:spotify_clone/service_locator.dart';

class SignUpUseCase extends UseCase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) async {
    return sl<AuthRepository>().signUp(params!);
  }
}
