import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/configs/constans/app_urls.dart';
import '../../../core/configs/themes/app_colors.dart';
import '../../bloc/profile_info/profile_info_cubit.dart';
import '../../bloc/profile_info/profile_info_state.dart';

class UserAvatarImage extends StatelessWidget {
  const UserAvatarImage({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
      builder: (context, state) {
        if (state is ProfileInfoLoading) {
          return const CircularProgressIndicator();
        }
        if (state is ProfileInfoLoaded) {
          return GestureDetector(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  30,
                ),
                color: AppColors.grey,
                image: DecorationImage(
                  image: state.userEntity.imageURL != null
                      ? NetworkImage(
                          state.userEntity.imageURL!,
                        )
                      : const AssetImage(
                          AppURLs.defaultImage,
                        ) as ImageProvider,
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
