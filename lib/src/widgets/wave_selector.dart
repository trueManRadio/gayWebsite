/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:truemanradio/src/player/base.dart';

class WaveSelectorWidget extends StatelessWidget {
  const WaveSelectorWidget({
    Key? key,
    required this.player,
  }) : super(key: key);

  final GayPlayer player;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.65),
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
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
                onPressed: (player.wave == GayWave.gay)
                    ? null
                    : () {
                        player.wave = GayWave.gay;
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
                onPressed: (player.wave == GayWave.trueGay)
                    ? null
                    : () {
                        player.wave = GayWave.trueGay;
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
                onPressed: (player.wave == GayWave.sadGay)
                    ? null
                    : () {
                        player.wave = GayWave.sadGay;
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
                onPressed: (player.wave == GayWave.none)
                    ? null
                    : () {
                        player.wave = GayWave.none;
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
    );
  }
}
