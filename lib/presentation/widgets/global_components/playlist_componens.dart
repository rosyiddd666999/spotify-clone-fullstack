import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/configs/assets/app_vectors.dart';
import '../../../core/configs/themes/app_colors.dart';
import '../../bloc/song/song_player/song_player_cubit.dart';

class AlbumComponents extends StatelessWidget {
  const AlbumComponents({
    super.key,
    required this.totalDuration,
    required this.namePlaylist,
    this.onTap,
  });

  final String totalDuration;
  final String namePlaylist;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  AppVectors.logo,
                  fit: BoxFit.cover,
                  height: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Spotify',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              totalDuration,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white60,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        BlocBuilder<SongPlayerCubit, SongPlayerState>(
          builder: (context, state) {
            final isPlaying = context.read<SongPlayerCubit>().currentPlaylist ==
                    namePlaylist &&
                context.read<SongPlayerCubit>().audioPlayer.playing;

            return GestureDetector(
              onTap: onTap,
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: AppColors.darkBackground,
                  size: 30,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
