/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:truemanradio/src/player/base.dart';

class TrackLoadErrorDialog extends StatelessWidget {
  const TrackLoadErrorDialog({
    Key? key,
    required this.player,
  }) : super(key: key);

  final GayPlayer player;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Error while loading track",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Error text"),
            Text(player.errorText, style: GoogleFonts.robotoMono()),
            const SizedBox(
              height: 10,
            ),
            const Text("Debug info"),
            Text("State: ${player.state.toString()}"),
            Text("Event: ${player.event.toString()}"),
            Text("Song name: ${player.song}"),
            Text("mp3: ${player.mp3}"),
            Text("Wave: ${player.wave}"),
            Text("Volume: ${player.volume.toStringAsFixed(2)}"),
            const SizedBox(
              height: 10,
            ),
            const Text("Please reload page to continue listening"),
          ],
        ),
      ),
    );
  }
}
