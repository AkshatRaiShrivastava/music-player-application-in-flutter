import 'package:music_player_application/views/widgets/lyrics_page.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player_application/constants/colors.dart';
import 'package:music_player_application/constants/strings.dart';
import 'package:music_player_application/views/widgets/art_work_image.dart';
import 'package:spotify/spotify.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../models/music.dart';

class MusicPlayer extends StatefulWidget {
  var trackID;
  MusicPlayer({this.trackID, super.key});
  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  Music music = Music();

  Color? songColor;
  String? artistName;
  String? songImage;
  String? songName;
  // String musicTrackId = ;
  Duration? duration;
  String? artistImage;
  final player = AudioPlayer();

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    music.trackId = widget.trackID;
    final credentials =
        SpotifyApiCredentials(CustomStrings.clientId, CustomStrings.secret);
    final spotify = SpotifyApi(credentials);
    spotify.tracks.get(music!.trackId.toString()).then((track) async {
      music.songName = track.name;
      music.artistImage = track.artists?.first.images?.first.url;
      music.artistName = track.artists?.first.name ?? "";
      String? image = track.album?.images?.first.url;
      if (image != null) {
        music.songImage = image;
        final tempSongColor = await getImagePalette(NetworkImage(image));
        if (tempSongColor != null){
          music.songColor = tempSongColor;
        }
      }
      if (music.songName != null) {
        print(music.songName);
        final yt = YoutubeExplode();
        final video = (await yt.search.search(music.songName!)).first;
        final videoId = video.id.value;
        music.duration = video.duration;

        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        var audioUrl = manifest.audioOnly.last.url;
        player.play(UrlSource(audioUrl.toString()));
        setState(() {});
      }
    });
  }

  Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: music.songColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    color: Colors.transparent,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${widget.trackID}",
                        style: textTheme.bodyMedium
                            ?.copyWith(color: CustomColors.primaryColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: music.artistImage != null
                                ? NetworkImage(music.artistImage!)
                                : null,
                            radius: 10,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            music.artistName!,
                            style: textTheme.bodyLarge
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Icon(
                    Icons.close,
                    color: Colors.white,
                  )
                ],
              ),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: ArtWorkImage(
                      image: music.songImage!,
                    ),
                  )),
              Flexible(
                child: Expanded(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                textDirection: TextDirection.ltr,
                                verticalDirection: VerticalDirection.down,
                                children: [
                                  Text(
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    music.songName!,
                                    style: textTheme.titleLarge
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ]),
                            Text(
                              music.artistName!,
                              style: textTheme.titleMedium
                                  ?.copyWith(color: Colors.white60),
                            )
                          ],
                        ),
                        const Icon(
                          Icons.favorite,
                          color: CustomColors.primaryColor,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    StreamBuilder(
                        stream: player.onPositionChanged,
                        builder: (context, data) {
                          return ProgressBar(
                              progress: data.data ?? const Duration(seconds: 0),
                              timeLabelTextStyle:
                                  const TextStyle(color: Colors.white),
                              total: music.duration ?? const Duration(minutes: 4),
                              bufferedBarColor: Colors.white38,
                              baseBarColor: Colors.white10,
                              thumbColor: Colors.white,
                              progressBarColor: Colors.white,
                              onSeek: (duration) {
                                player.seek(duration);
                              });
                        }),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LyricsPage(
                                          music: music,
                                          player: player,
                                        )));
                          },
                          icon: const Icon(Icons.lyrics_outlined),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_previous,
                            size: 36,
                          ),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () async {
                            if (player.state == PlayerState.playing) {
                              await player.pause();
                            } else {
                              await player.resume();
                            }
                            setState(() {});
                          },
                          icon: Icon(
                            player.state == PlayerState.playing
                                ? Icons.pause
                                : Icons.play_circle,
                            size: 60,
                          ),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_next,
                            size: 36,
                          ),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.loop),
                          color: CustomColors.primaryColor,
                        ),
                      ],
                    )
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
