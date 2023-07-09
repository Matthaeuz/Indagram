import 'package:flutter/material.dart';
import 'package:indagram/constants.dart';
import 'package:indagram/state/helpers/video_helpers.dart';

class VideoThumb extends StatefulWidget {
  const VideoThumb({super.key, required this.video});

  final String video;

  @override
  State<VideoThumb> createState() => _VideoThumbState();
}

class _VideoThumbState extends State<VideoThumb> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getThumb(widget.video),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Container();
          } else if (snapshot.hasData) {
            return snapshot.data!;
          }
        }
        return const SizedBox(
          height: 80.0,
          width: double.infinity,
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.bodyTextColor,
            ),
          ),
        );
      },
    );
  }
}
