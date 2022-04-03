import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Pleer extends StatefulWidget {
  const Pleer({Key? key}) : super(key: key);

  @override
  State<Pleer> createState() => _PleerState();
}

class _PleerState extends State<Pleer> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  late AudioPlayer _player;
  late AudioCache cache;

  Duration position = const Duration();
  Duration musicLength = const Duration();

  Widget slider() {
    return SizedBox(
      width: 300,
      child: Slider.adaptive(
        activeColor: Colors.blue[800],
        inactiveColor: Colors.grey[350],
        value: position.inSeconds.toDouble(),
        max: musicLength.inSeconds.toDouble(),
        onChanged: (value) {
          seekToSec(value.toInt());
        },
      ),
    );
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.onDurationChanged.listen(
      (d) {
        setState(() {
          musicLength = d;
        });
      },
    );

    _player.onAudioPositionChanged.listen((p) {
      setState(() {
        position = p;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[800] as Color,
              Colors.blue[200] as Color,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    'Music Beats',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    'Listen to your favourite Music',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                Center(
                  child: Container(
                    width: 280.0,
                    height: 280.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18.0),
                const Center(
                  child: Text(
                    'Kino',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 30.0),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 500,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${position.inMinutes}:${position.inSeconds.remainder(60)}',
                                style: const TextStyle(fontSize: 18.0),
                              ),
                              slider(),
                              Text(
                                '${musicLength.inMinutes}:${musicLength.inSeconds.remainder(60)}',
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.skip_previous),
                              iconSize: 45.0,
                              color: Colors.blue,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (!playing) {
                                    cache.play('kino.mp3');
                                    playBtn = Icons.pause;
                                    playing = true;
                                  } else {
                                    _player.pause();
                                    playBtn = Icons.play_arrow;
                                    playing = false;
                                  }
                                });
                              },
                              icon: Icon(playBtn),
                              iconSize: 62.0,
                              color: Colors.blue[800],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.skip_next),
                              iconSize: 45.0,
                              color: Colors.blue,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
