import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerComponent extends StatefulWidget {
  const VideoPlayerComponent({super.key});

  @override
  State<VideoPlayerComponent> createState() => _VideoPlayerComponentState();
}

class _VideoPlayerComponentState extends State<VideoPlayerComponent> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  int currentIndex = 0;
  List<Map<String, dynamic>> videosList = [
    {
      'tittle': '1.mp4',
      'video': 'assets/videos/1.mp4',
    },
    {
      'tittle': '2.mp4',
      'video': 'assets/videos/2.mp4',
    },
    {
      'tittle': '3.mp4',
      'video': 'assets/videos/3.mp4',
    },
    {
      'tittle': '4.mp4',
      'video': 'assets/videos/4.mp4',
    },
  ];
  @override
  void initState() {
    super.initState();
    loadVideo(currentIndex);
  }

  loadVideo(int index) async {
    videoPlayerController =
        VideoPlayerController.asset(videosList[index]['video']);
    await videoPlayerController.initialize();

    chewieController?.dispose();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
    );

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
    chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: (chewieController == null)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 15,
                    child: AspectRatio(
                      aspectRatio: 4 / 3,
                      child: Chewie(controller: chewieController!),
                    ),
                  ),
                ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: ListView.builder(
                itemCount: videosList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    selected: (currentIndex == index) ? true : false,
                    selectedTileColor: Colors.blue,
                    selectedColor: Colors.white,
                    title: Text(videosList[index]['tittle']),
                    onTap: () {
                      currentIndex = index;
                      loadVideo(index);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
