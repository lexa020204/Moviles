import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final String sNombre;
  final String sTiempo;
  final String sTamano;
  final String sImagen;
  final String sUrl;
  
  const Video({super.key, required this.sNombre,
    required this.sTiempo,
    required this.sTamano,
    required this.sImagen,
    required this.sUrl,});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;
 

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.sUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const  CircularProgressIndicator(),
        IconButton(
          icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            setState(() {
              _controller.value.isPlaying ? _controller.pause() : _controller.play();
            });
          },
        ),
        Text(widget.sNombre),
        Text(widget.sTiempo),
        Text(widget.sTamano),
      ],
    );
  }
}