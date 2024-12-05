import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import '../../core.dart';

class SpeedDialWidget extends StatelessWidget {
  SpeedDialWidget({
    Key? key,
  }) : super(key: key);
  CommonService commonService = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => commonService.isAudioPlaying.value
          ? FloatingActionButton(
              onPressed: () {},
              child: SpeedDial(
                icon: Icons.audiotrack,
                curve: Curves.bounceIn,
                backgroundColor: Get.theme.colorScheme.primary,
                children: [
                  SpeedDialChild(
                    onTap: () {
                      AssetsAudioPlayer.allPlayers().forEach((key, value) {
                        value.stop();
                      });
                    },
                    foregroundColor: Get.theme.highlightColor,
                    backgroundColor: Get.theme.colorScheme.secondary,
                    child: Icon(
                      Icons.stop,
                      color: Get.theme.highlightColor,
                    ),
                  ),
                  SpeedDialChild(
                    onTap: () {
                      AssetsAudioPlayer.allPlayers().forEach((key, value) {
                        value.playOrPause();
                      });
                    },
                    foregroundColor: Get.theme.highlightColor,
                    backgroundColor: Get.theme.colorScheme.secondary,
                    child: StreamBuilder(
                        stream: commonService.assetsAudioPlayer.value.isPlaying,
                        builder: (context, asyncSnapshot) {
                          final bool isPlaying = asyncSnapshot.data as bool;
                          return Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Get.theme.highlightColor,
                          );
                        }),
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
