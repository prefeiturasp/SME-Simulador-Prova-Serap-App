import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:serap_simulador/core/interfaces/I_loggable.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String? videoPath;
  final String? videoUrl;

  VideoPlayerWidget({
    super.key,
    this.videoPath,
    this.videoUrl,
  });

  @override
  State createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> with ILoggable {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  final double _aspectRatio = 16 / 9;

  @override
  initState() {
    super.initState();

    if (widget.videoUrl != null) {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl!));
    } else {
      _videoPlayerController = VideoPlayerController.file(File(widget.videoPath!));
      info(widget.videoPath!);
    }

    _chewieController = ChewieController(
      allowedScreenSleep: false,
      allowFullScreen: false,
      videoPlayerController: _videoPlayerController,
      aspectRatio: _aspectRatio,
      autoInitialize: true,
      autoPlay: true,
      showControls: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.pause();

    _chewieController.dispose();
    _videoPlayerController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController,
    );
  }
}
