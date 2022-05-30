/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kplayer/kplayer.dart';
import 'package:provider/provider.dart';
import 'package:truemanradio/player.dart';

// There's nothing hard to do, so I was too lazy to use OOP...
// also I was too lazy to remove app template parts.....

void main() {
  Player.boot();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'True Man Radio',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GayPlayer(),
        ),
      ],
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icon.svg",
                semanticsLabel: 'Logo',
                width: MediaQuery.of(context).size.height / 32,
                height: MediaQuery.of(context).size.height / 32,
              ),
              const SizedBox(
                width: 10,
              ),
              ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0.5),
                  ],
                  end: Alignment.bottomLeft,
                  begin: Alignment.topRight,
                ).createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                ),
                child: const Text(
                  "TRUE MAN RADIO",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SizedBox.expand(
          child: Stack(
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Image.asset(
                  "assets/gym.jpg",
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(200),
                      ),
                      child: Center(
                        child: Consumer<GayPlayer>(
                          builder: (context, value, child) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Choose your gay wave:",
                                style: GoogleFonts.roboto(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                onPressed: (value.wave == GayWave.gay)
                                    ? null
                                    : () {
                                        value.wave = GayWave.gay;
                                      },
                                child: Text(
                                  "GAY",
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 36,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                onPressed: (value.wave == GayWave.trueGay)
                                    ? null
                                    : () {
                                        value.wave = GayWave.trueGay;
                                      },
                                child: Text(
                                  "TRUE GAY",
                                  style: GoogleFonts.oswald(
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 36,
                                    color: Colors.purpleAccent,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                onPressed: (value.wave == GayWave.sadGay)
                                    ? null
                                    : () {
                                        value.wave = GayWave.sadGay;
                                      },
                                child: Text(
                                  "sad gay...",
                                  style: GoogleFonts.qwigley(
                                    fontWeight: FontWeight.w200,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 36,
                                    color: Colors.blue.shade200,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                onPressed: (value.wave == GayWave.none)
                                    ? null
                                    : () {
                                        value.wave = GayWave.none;
                                      },
                                child: Text(
                                  "None",
                                  style: GoogleFonts.roboto(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Consumer<GayPlayer>(
                    builder: (context, value, child) => (value.wave !=
                            GayWave.none)
                        ? Container(
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                if (value.wave == GayWave.gay)
                                  Text(
                                    "GAY",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 24,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                if (value.wave == GayWave.trueGay)
                                  Text(
                                    "TRUE GAY",
                                    style: GoogleFonts.oswald(
                                      fontWeight: FontWeight.w900,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 24,
                                      color: Colors.purpleAccent,
                                    ),
                                  ),
                                if (value.wave == GayWave.sadGay)
                                  Text(
                                    "sad gay...",
                                    style: GoogleFonts.qwigley(
                                      fontWeight: FontWeight.w200,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 24,
                                      color: Colors.blue.shade200,
                                    ),
                                  ),
                                const SizedBox(width: 20),
                                const Icon(Icons.music_note),
                                const SizedBox(width: 20),
                                Text(value.song),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Slider(
                                        onChanged: (v) {
                                          value.volume = v;
                                        },
                                        value: value.volume,
                                        activeColor: Colors.white,
                                        inactiveColor:
                                            Colors.white.withOpacity(0.2),
                                      ),
                                      const SizedBox(width: 20),
                                      const Icon(Icons.volume_up),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
