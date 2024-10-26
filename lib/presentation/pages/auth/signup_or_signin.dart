import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone/common/helpers/is_theme_bool.dart';
import 'package:spotify_clone/core/configs/themes/app_colors.dart';

import '../../../common/widgets/app_bar/default_app_bar.dart';
import '../../../common/widgets/button/main_button.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/routes/routes.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BasicAppbar(
            hideBack: true,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Color(0xE6FFFFFF),
                    Color(0xCCFFFFFF),
                    Color(0xB3FFFFFF),
                    Color(0x99FFFFFF),
                    Color(0x80FFFFFF),
                    Color(0x66FFFFFF),
                    Color(0x4DFFFFFF),
                    Color(0x33FFFFFF),
                    Color(0x1AFFFFFF),
                    Color(0x0DFFFFFF),
                    Color(0x05FFFFFF),
                    Colors.transparent,
                    Colors.transparent,
                  ],
                  stops: [
                    0.0,
                    0.1,
                    0.2,
                    0.3,
                    0.4,
                    0.5,
                    0.55,
                    0.60,
                    0.65,
                    0.70,
                    0.75,
                    0.80,
                    0.85,
                    0.90,
                    0.93,
                    0.96,
                    0.98,
                    1.0,
                  ],
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                height: MediaQuery.of(context).size.height * 0.50,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          AppImages.songBackground,
                        ))),
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: MediaQuery.of(context).size.height * 0.20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppVectors.logo,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Enjoy listening to music.\nFree on Spotify',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                        color: context.isDarkMode
                            ? AppColors.lightBackground
                            : AppColors.darkBackground,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        BasicAppButton(
                          height: 50,
                          colorTheme: true,
                          onPressed: () {
                            context.goNamed(Routes.signUp);
                          },
                          title: 'Sign up free',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            context.goNamed(Routes.signIn);
                          },
                          child: Text(
                            'Log in',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
