import 'package:dartz/dartz.dart';

import '../../../data/models/auth/create_user.dart';
import '../../../data/models/auth/sign_in_user.dart';

abstract class AuthRepository {
  Future<Either> signUp(CreateUserReq createUserReq);
  Future<Either> signIn(SignInUserReq signInUserReq);
  Future<Either> getUser();
}
