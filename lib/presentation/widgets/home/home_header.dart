import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_clone/core/configs/to_uppercase/to_uppercase.dart';
import 'package:spotify_clone/presentation/bloc/profile_info/profile_info_state.dart';

import '../../../core/configs/constans/app_urls.dart';
import '../../../core/configs/themes/app_colors.dart';
import '../../bloc/profile_info/profile_info_cubit.dart';

class HomeHeader extends StatelessWidget {
  final Function() onTapDrawer;

  const HomeHeader({
    super.key,
    required this.onTapDrawer,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
      builder: (context, state) {
        if (state is ProfileInfoLoading) {
          return const CircularProgressIndicator();
        }
        if (state is ProfileInfoLoaded) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 16,
              ),
              GestureDetector(
                onTap: onTapDrawer,
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
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                toTitleCase(
                  state.userEntity.fullName!.isNotEmpty
                      ? 'Welcome!, ${state.userEntity.fullName}👋'
                      : '',
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
