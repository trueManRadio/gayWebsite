/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:truemanradio/src/saveable/ad_chance.dart';
import 'package:truemanradio/src/saveable/low_performance.dart';
import 'package:truemanradio/src/pages/main.dart';
import 'package:truemanradio/src/player/base.dart';

class PreloadPage extends StatelessWidget {
  const PreloadPage({
    Key? key,
    required this.lastAdChance,
    required this.lastLpState,
  }) : super(key: key);

  final int lastAdChance;
  final LowPerformanceModeState lastLpState;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GayTrackList>(
          create: (context) => GayTrackList(),
        ),
        ChangeNotifierProvider<LowPerformanceModeInfo>(
          create: (context) => LowPerformanceModeInfo(
            lastLpState,
          ),
        ),
        Provider<AdChanceInfo>(
          create: (context) => AdChanceInfo(
            lastChance: lastAdChance,
          ),
        ),
        ChangeNotifierProvider<GayPlayer>(
          create: (context) => GayPlayer(
            trackList: context.read<GayTrackList>(),
            adChance: context.read<AdChanceInfo>(),
          ),
        ),
      ],
      builder: (context, _) => FutureBuilder(
        future: context.read<GayTrackList>().load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Failed to load tracklist"),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width / 4,
                            ),
                            child: SingleChildScrollView(
                              child: Text(
                                snapshot.error.toString(),
                                style: GoogleFonts.robotoMono(
                                  color: Colors.grey,
                                ),
                                maxLines: 9999,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const MainPage();
            }
          } else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    Text("Loading tracklist..."),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
