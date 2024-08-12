import 'package:flutter/material.dart';
import 'package:media_booster/views/components/audio_player_component.dart';
import 'package:media_booster/views/components/video_player_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Media Booster'),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('Audio Player'),
              ),
              Tab(
                child: Text('Video Player'),
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AudioPlayerComponent(),
            VideoPlayerComponent(),
          ],
        ),
      ),
    );
  }
}
