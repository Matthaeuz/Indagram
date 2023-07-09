import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Future<Image> getThumb(video) async {
  final thumbnail = await VideoThumbnail.thumbnailData(video: video);
  if (thumbnail == null) {
    throw Exception();
  }
  return Image.memory(
    thumbnail,
    fit: BoxFit.cover,
  );
}
