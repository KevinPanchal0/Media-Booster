import 'package:flutter/material.dart';
import 'package:media_booster/models/audio_play_model.dart';

class AudioPlayProvider with ChangeNotifier {
  AudioPlayModel audioPlayModel = AudioPlayModel(isPlaying: false);

  void togglePlay(bool isPlaying) {
    audioPlayModel.isPlaying = isPlaying;
    notifyListeners();
  }
}
