import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:serap_simulador/core/utils/colors.dart';

import 'audio_player.controller.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String? audioPath;
  final Uint8List? audioBytes;

  AudioPlayerWidget({
    Key? key,
    this.audioPath,
    this.audioBytes,
  }) : super(key: key);

  @override
  State createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  var controller = AudioPlayerController();

  @override
  void initState() {
    super.initState();
    controller.init();
    controller.setFilePlayer(widget.audioPath);
    controller.setBytePlayer(widget.audioBytes);
  }

  @override
  void dispose() {
    controller.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      height: 76,
      child: Observer(builder: (_) {
        return Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
              ),
              width: 72,
              height: 75,
              child: _buildControlButtons(),
            ),
            Expanded(
              child: Slider(
                activeColor: TemaUtil.appBar,
                thumbColor: TemaUtil.appBar,
                inactiveColor: Colors.black.withOpacity(0.1),
                value: controller.position + 0.0,
                min: 0.0,
                max: controller.duration!.inMilliseconds + 0.0,
                onChanged: controller.seek,
              ),
            ),
          ],
        );
      }),
    );
  }

  _buildControlButtons() {
    if (controller.isPlaying) {
      return IconButton(
        iconSize: 50,
        icon: Icon(
          Icons.pause_rounded,
          color: TemaUtil.appBar,
        ),
        onPressed: () async {
          await controller.pausePlayer();
        },
      );
    }

    return IconButton(
      iconSize: 50,
      icon: Icon(
        Icons.play_arrow_rounded,
        color: TemaUtil.appBar,
      ),
      onPressed: () async {
        await controller.playFile();
      },
    );
  }
}
