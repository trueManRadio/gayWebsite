/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';
import 'package:truemanradio/player.dart';

class PlayerWidget extends StatelessWidget {
  const PlayerWidget({Key? key, required this.player}) : super(key: key);

  final GayPlayer player;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withAlpha(200),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
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
              const SizedBox(width: 20),
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
                  maxLines: 3,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Slider(
                      onChanged: (v) {
                        player.volume = v;
                      },
                      value: player.volume,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  Icon(
                    player.volume == 0.0
                        ? Icons.volume_off
                        : player.volume < 0.6
                            ? Icons.volume_down
                            : Icons.volume_up,
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
