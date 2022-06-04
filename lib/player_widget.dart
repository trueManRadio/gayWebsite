/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:provider/provider.dart';
import 'package:truemanradio/low_performance.dart';
import 'package:truemanradio/player.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({Key? key, required this.player}) : super(key: key);

  final GayPlayer player;

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width /
            MediaQuery.of(context).devicePixelRatio >
        700;

    Widget playerWidget = Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.85),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              if (isDesktop) ...[
                if (player.wave == GayWave.gay)
                  Text(
                    "GAY",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: Colors.blueGrey,
                    ),
                  ),
                if (player.wave == GayWave.trueGay)
                  Text(
                    "TRUE GAY",
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontSize: 24,
                      color: Colors.purpleAccent,
                    ),
                  ),
                if (player.wave == GayWave.sadGay)
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
              ],
              // Loading
              if (player.event == GayPlayerEvent.loading)
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3.0,
                  ),
                ),
              // Error
              if (player.event == GayPlayerEvent.error)
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              if (player.event != GayPlayerEvent.loading &&
                  player.event != GayPlayerEvent.error)
                const MiniMusicVisualizer(
                  color: Colors.white,
                  width: 4,
                  height: 15,
                ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  player.getPlayerText(),
                  maxLines: 5,
                  style: TextStyle(
                    fontSize: isDesktop ? 16 : 12,
                  ),
                  textAlign: isDesktop ? TextAlign.left : TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isDesktop)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                      child: Slider(
                        onChanged: (v) {
                          player.volume = v;
                        },
                        value: player.volume,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    Icon(player.volume == 0.0
                        ? Icons.volume_off
                        : player.volume < 0.6
                            ? Icons.volume_down
                            : Icons.volume_up)
                  ],
                ),
            ],
          ),
          if (!isDesktop) ...[
            Row(
              children: [
                if (player.wave == GayWave.gay)
                  Text(
                    "GAY",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: Colors.blueGrey,
                    ),
                  ),
                if (player.wave == GayWave.trueGay)
                  Text(
                    "TRUE GAY",
                    style: GoogleFonts.oswald(
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      fontSize: 24,
                      color: Colors.purpleAccent,
                    ),
                  ),
                if (player.wave == GayWave.sadGay)
                  Text(
                    "sad gay...",
                    style: GoogleFonts.qwigley(
                      fontWeight: FontWeight.w200,
                      fontStyle: FontStyle.italic,
                      fontSize: 24,
                      color: Colors.blue.shade200,
                    ),
                  ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Slider(
                          onChanged: (v) {
                            player.volume = v;
                          },
                          value: player.volume,
                          activeColor: Colors.white,
                          inactiveColor: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      Icon(player.volume == 0.0
                          ? Icons.volume_off
                          : player.volume < 0.6
                              ? Icons.volume_down
                              : Icons.volume_up)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );

    return Consumer<LowPerformanceModeInfo>(
      builder: (context, value, child) => Column(
        children: [
          value.state == LowPerformanceModeState.enabled
              ? playerWidget
              : ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 8.0,
                      sigmaY: 8.0,
                    ),
                    child: playerWidget,
                  ),
                ),
        ],
      ),
    );
  }
}
