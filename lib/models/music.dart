import 'package:flutter/material.dart';

class Music {
  String? trackId;
  Duration? duration;
  String? artistName;
  String? songName;
  String? songImage;
  String? artistImage;
  Color? songColor;

  Music(
      {this.duration,
      this.trackId,
      this.artistName,
      this.songName,
      this.songImage,
      this.artistImage,
      this.songColor});
}
