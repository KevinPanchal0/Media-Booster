import 'package:flutter/material.dart';
import 'package:media_booster/controller/provider/audio_play_provider.dart';
import 'package:media_booster/controller/provider/current_playing_provider.dart';
import 'package:media_booster/views/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AudioPlayProvider()),
        ChangeNotifierProvider(create: (context) => CurrentPlayingProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
