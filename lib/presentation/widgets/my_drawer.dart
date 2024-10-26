import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/common/helpers/is_theme_bool.dart';

import '../../core/configs/constans/app_urls.dart';
import '../../core/configs/themes/app_colors.dart';
import '../../core/routes/routes.dart';
import '../bloc/profile_info/profile_info_cubit.dart';
import '../bloc/profile_info/profile_info_state.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  void signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    context.goNamed(
      Routes.signUpOrsignIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: Container(
        width: 220,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.zero,
          color:
              context.isDarkMode ? AppColors.darkGrey2 : AppColors.components,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              width: double.infinity,
              child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
                builder: (context, state) {
                  if (state is ProfileInfoLoading) {
                    return Container(
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(),
                    );
                  }
                  if (state is ProfileInfoLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: state.userEntity.imageURL != null
                                  ? NetworkImage(state.userEntity.imageURL!)
                                  : const AssetImage(AppURLs.defaultImage)
                                      as ImageProvider,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          state.userEntity.fullName ?? 'Failure',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(state.userEntity.email ?? ''),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: AppColors.darkGrey,
                        ),
                      ],
                    );
                  }

                  if (state is ProfileInfoFailure) {
                    return const Text('Please try again');
                  }
                  return Container();
                },
              ),
            ),
            ListTile(
              title: const Text('Logout'),
              leading: IconButton(
                onPressed: () => signUserOut(context),
                icon: const Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
