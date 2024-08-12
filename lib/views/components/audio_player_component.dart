import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:media_booster/controller/provider/audio_play_provider.dart';
import 'package:media_booster/controller/provider/current_playing_provider.dart';
import 'package:provider/provider.dart';

class AudioPlayerComponent extends StatefulWidget {
  const AudioPlayerComponent({super.key});

  @override
  State<AudioPlayerComponent> createState() => _AudioPlayerComponentState();
}

class _AudioPlayerComponentState extends State<AudioPlayerComponent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  CarouselSliderController carouselSliderController =
      CarouselSliderController();
  List<Map<String, dynamic>> audioImageList = [
    {
      'tittle': 'Be Mine',
      'image': 'assets/images/be_mine.jpeg',
      'author': 'Shubh',
    },
    {
      'tittle': 'Big Dwags',
      'image': 'assets/images/big_dwags.jpeg',
      'author': 'Hanumankind & Kalmi',
    },
    {
      'tittle': 'BlockBuster',
      'image': 'assets/images/blockbuster.jpeg',
      'author': 'Faris Shafi, Umair Butt &\nGharvi Group',
    },
    {
      'tittle': 'Illuminati',
      'image': 'assets/images/illuminati.jpeg',
      'author': 'Sushin Shyam',
    },
    {
      'tittle': 'Rang Bhini Radha',
      'image': 'assets/images/rang_bhini_radha.jpeg',
      'author': 'Aditiya Gadhvi',
    },
  ];
  List<Audio> audioList = [
    Audio(
      'assets/songs/be_mine.mp3',
      metas: Metas(
        image: MetasImage(
            path: 'assets/images/be_mine.jpeg', type: ImageType.asset),
        title: 'Be Mine',
      ),
    ),
    Audio(
      'assets/songs/big_dwags.mp3',
      metas: Metas(
        image: MetasImage(
            path: 'assets/images/big_dwags.jpeg', type: ImageType.asset),
        title: 'Big Dwags',
      ),
    ),
    Audio(
      'assets/songs/blockbuster.mp3',
      metas: Metas(
        image: MetasImage(
            path: 'assets/images/blockbuster.jpeg', type: ImageType.asset),
        title: 'BlockBuster',
      ),
    ),
    Audio(
      'assets/songs/illuminati.mp3',
      metas: Metas(
        image: MetasImage(
            path: 'assets/images/illuminati.jpeg', type: ImageType.asset),
        title: 'Illuminati',
      ),
    ),
    Audio(
      'assets/songs/rang_bhini_radha.mp3',
      metas: Metas(
        image: MetasImage(
            path: 'assets/images/rang_bhini_radha.jpeg', type: ImageType.asset),
        title: 'Rang Bhini Radha',
      ),
    ),
  ];
  @override
  void initState() {
    super.initState();
    assetsAudioPlayer.open(
      Playlist(audios: audioList),
      autoStart: false,
      showNotification: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final playProvider = Provider.of<AudioPlayProvider>(context);
    final currentPlaying = Provider.of<CurrentPlayingProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                      stream: assetsAudioPlayer.current,
                      builder: (context, snapshot) {
                        final currentAudio =
                            snapshot.data?.audio.assetAudioPath;
                        final currentIndex = audioList
                            .indexWhere((audio) => audio.path == currentAudio);

                        if (currentIndex != -1) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            carouselSliderController
                                .animateToPage(currentIndex);
                          });
                        }
                        return CarouselSlider(
                          carouselController: carouselSliderController,
                          items: List.generate(audioImageList.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                elevation: 10,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(15),
                                        topLeft: Radius.circular(15),
                                      ),
                                      child: Image.asset(
                                        audioImageList[index]['image'],
                                        fit: BoxFit.fill,
                                        height: 200,
                                        width: 200,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      audioImageList[index]['tittle'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      audioImageList[index]['author'],
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          options: CarouselOptions(
                            viewportFraction: 1,
                            height: 300,
                            autoPlay: false,
                            enableInfiniteScroll: true,
                            onPageChanged: (index, _) async {
                              currentPlaying.changeIndex(currentIndex);
                              playProvider.togglePlay(true);
                            },
                          ),
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await assetsAudioPlayer.previous();
                          playProvider.togglePlay(true);
                          carouselSliderController.previousPage();
                        },
                        icon: const Icon(Icons.skip_previous_outlined),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (playProvider.audioPlayModel.isPlaying == false) {
                            await assetsAudioPlayer.play();
                            playProvider.togglePlay(true);
                          } else {
                            await assetsAudioPlayer.pause();
                            playProvider.togglePlay(false);
                          }
                        },
                        icon: (playProvider.audioPlayModel.isPlaying == false)
                            ? const Icon(Icons.play_arrow)
                            : const Icon(Icons.pause),
                      ),
                      IconButton(
                        onPressed: () async {
                          await assetsAudioPlayer.next(
                              keepLoopMode: false, stopIfLast: false);
                          playProvider.togglePlay(true);
                          carouselSliderController.nextPage();
                        },
                        icon: const Icon(Icons.skip_next_outlined),
                      ),
                    ],
                  ),
                  StreamBuilder(
                    stream: assetsAudioPlayer.currentPosition,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('There is some problem loading Music'),
                        );
                      } else if (snapshot.hasData) {
                        Duration? currentPosition = snapshot.data;
                        Duration totalDuration =
                            (assetsAudioPlayer.current.valueOrNull == null)
                                ? Duration(seconds: 0)
                                : assetsAudioPlayer
                                    .current.value!.audio.duration;

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(currentPosition.toString().split('.')[0]),
                            Slider(
                              min: 0,
                              max: (assetsAudioPlayer.current.valueOrNull ==
                                      null)
                                  ? 0
                                  : totalDuration.inSeconds.toDouble(),
                              value: (currentPosition == null)
                                  ? 0
                                  : currentPosition.inSeconds.toDouble(),
                              onChanged: (val) async {
                                await assetsAudioPlayer
                                    .seek(Duration(seconds: val.toInt()));
                              },
                            ),
                            Text(totalDuration.toString().split('.')[0]),
                          ],
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ],
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
                  itemCount: audioImageList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(audioImageList[index]['image']),
                      ),
                      selected:
                          (currentPlaying.currentPlayingModel.currentIndex ==
                                  index)
                              ? true
                              : false,
                      selectedColor: Colors.white,
                      selectedTileColor: Colors.black,
                      title: Text(
                        audioImageList[index]['tittle'],
                      ),
                      onTap: () async {
                        await assetsAudioPlayer.playlistPlayAtIndex(index);
                      },
                    );
                  }),
            ),
          ),
        )
      ],
    );
  }
}
