import 'dart:io';

import 'package:flutter/material.dart';
import 'package:indagram/constants.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({super.key, required this.video});

  final String video;

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  late VideoPlayerController _controller;
  IconData icon = Icons.play_arrow;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(
      File(widget.video),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then((_) {
        _controller.play();
        setState(() {});
      });
    ;
    _controller.addListener(checkVideo);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void handleClick() {
    if (_controller.value.position == _controller.value.duration) {
      _controller.seekTo(const Duration(seconds: 0));
      _controller.play();
    } else if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  void checkVideo() {
    if (_controller.value.position == _controller.value.duration) {
      setState(() {
        icon = Icons.restart_alt;
      });
    } else if (_controller.value.isPlaying) {
      setState(() {
        icon = Icons.pause;
      });
    } else {
      setState(() {
        icon = Icons.play_arrow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  const ClosedCaption(text: null),
                  VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    padding: const EdgeInsets.only(
                        left: 52.0, right: 8.0, top: 8.0, bottom: 20.0),
                    colors: const VideoProgressColors(
                      playedColor: AppColors.appBarFgColor,
                      backgroundColor: AppColors.bodyColor,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: IconButton(
                      onPressed: () {
                        handleClick();
                      },
                      icon: Icon(
                        icon,
                        color: AppColors.appBarFgColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox(
              height: 120.0,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.bodyTextColor,
                ),
              ),
            ),
    );
  }
}
