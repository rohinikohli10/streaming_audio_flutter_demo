import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'page_manager.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final PageManager _pageManager;

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.purple,
          primarySwatch: Colors.lime),
      darkTheme: ThemeData.dark(),
      home: MyUIMusic(),
    );
  }
}

List<Map<String, dynamic>> audioExamples = [
  <String, dynamic>{
    'title': 'Salt & Pepper',
    'singer': 'Dope Lemon',
    'img': 'https://m.media-amazon.com/images/I/81UYWMG47EL._SS500_.jpg',
    'song': 'https://dl.espressif.com/dl/audio/gs-16b-2c-44100hz.mp3',
    'isplayed': false
  },
  <String, dynamic>{
    'title': 'Losing It',
    'singer': 'FISHER',
    'img': 'https://m.media-amazon.com/images/I/9135KRo8Q7L._SS500_.jpg',
    'song': 'https://www.kozco.com/tech/piano2-Audacity1.2.5.mp3',
    'isplayed': false
  },
  <String, dynamic>{
    'title': 'American Kids',
    'singer': 'Kenny Chesney',
    'img':
        'https://cdn.playbuzz.com/cdn/7ce5041b-f9e8-4058-8886-134d05e33bd7/5c553d94-4aa2-485c-8a3f-9f496e4e4619.jpg',
    'song': 'https://www.kozco.com/tech/organfinale.mp3',
    'isplayed': false
  },
  <String, dynamic>{
    'title': 'Wake Me Up',
    'singer': 'Avicii',
    'img':
        'https://upload.wikimedia.org/wikipedia/en/d/da/Avicii_Wake_Me_Up_Official_Single_Cover.png',
    'song': 'https://www.kozco.com/tech/32.mp3',
    'isplayed': false
  },
  <String, dynamic>{
    'title': 'Missing You',
    'singer': 'Mesto',
    'img':
        'https://img.discogs.com/EcqkrmOCbBguE3ns-HrzNmZP4eM=/fit-in/600x600/filters:strip_icc():format(jpeg):mode_rgb():quality(90)/discogs-images/R-12539198-1537229070-5497.jpeg.jpg',
    'song': 'https://www.kozco.com/tech/LRMonoPhase4.mp3',
    'isplayed': false
  },
  <String, dynamic>{
    'title': 'My heart goes on',
    'singer': 'Tash Sultana',
    'img': 'https://m.media-amazon.com/images/I/91vBpel766L._SS500_.jpg',
    'song': 'https://www.kozco.com/tech/LRMonoPhase4.wav',
    'isplayed': false
  },
  <String, dynamic>{
    'title': 'Ego Death',
    'singer': 'Ty Dolla \$ign, Kanye West, FKA Twigs, Skrillex',
    'img':
        'https://static.stereogum.com/uploads/2020/06/Ego-Death-1593566496.jpg',
    'song': 'https://www.kozco.com/tech/c304-2.wav',
    'isplayed': false
  },
];

class MyUIMusic extends StatefulWidget {
  MyUIMusic({Key? key}) : super(key: key);

  @override
  State<MyUIMusic> createState() => _MyUIMusicState();
}

class _MyUIMusicState extends State<MyUIMusic> {
  late final PageManager _pageManager;

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  height: 120,
                  child: ListTile(
                    trailing: Container(
                      child: ValueListenableBuilder<ButtonState>(
                        valueListenable: _pageManager.buttonNotifier,
                        builder: (_, value, __) {
                          switch (value) {
                            case ButtonState.loading:
                              return Container(
                                margin: const EdgeInsets.all(8.0),
                                width: 32.0,
                                height: 32.0,
                                child: const CircularProgressIndicator(),
                              );
                            case ButtonState.paused:
                              return IconButton(
                                icon: const Icon(Icons.play_arrow),
                                iconSize: 32.0,
                                onPressed: _pageManager.play,
                              );
                            case ButtonState.playing:
                              return IconButton(
                                icon: const Icon(Icons.pause),
                                iconSize: 32.0,
                                onPressed: _pageManager.pause,
                              );
                          }
                        },
                      ),
                    ),
                    title: Text(audioExamples[index]['title'] as String),
                    subtitle: Container(
                      child: ValueListenableBuilder<ProgressBarState>(
                        valueListenable: _pageManager.progressNotifier,
                        builder: (_, value, __) {
                          return ProgressBar(
                            progress: value.current,
                            buffered: value.buffered,
                            total: value.total,
                            onSeek: _pageManager.seek,
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
