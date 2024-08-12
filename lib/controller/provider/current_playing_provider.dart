import 'package:flutter/material.dart';
import 'package:media_booster/models/current_playing_model.dart';

class CurrentPlayingProvider with ChangeNotifier {
  CurrentPlayingModel currentPlayingModel =
      CurrentPlayingModel(currentIndex: 0);

  void changeIndex(int i) {
    currentPlayingModel.currentIndex = i;
    notifyListeners();
  }
}
