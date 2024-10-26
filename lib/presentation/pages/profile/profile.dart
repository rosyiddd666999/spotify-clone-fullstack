import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone/core/configs/themes/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _profileInfo(context),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      child: SingleChildScrollView(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Text(
                                'Create By',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Abdul Rosyid',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          const Text(
                            'For more information follow my instagram @rosyiddd_',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Container(),
                        ],
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.50,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              SvgPicture.asset(
                AppVectors.whiteLogo,
                fit: BoxFit.cover,
                height: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'This application is just a fake Spotify, its purpose is only as a personal project',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightBackground,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Download real Spotify',
                    style: TextStyle(
                      color: AppColors.darkBackground,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
