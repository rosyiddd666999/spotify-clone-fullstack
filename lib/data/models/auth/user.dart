// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:spotify_clone/domain/entities/auth/auth_entity.dart';

class UserModel {
  String? email;
  String? fullName;
  String? imageURL;

  UserModel({
    required this.email,
    required this.fullName,
    required this.imageURL,
  });

  UserModel.fromJson(Map<String, dynamic> data) {
    fullName = data['name'];
    email = data['email'];
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      fullName: fullName,
      imageURL: imageURL,
    );
  }
}
