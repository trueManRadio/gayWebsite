/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:truemanradio/src/saveable/ad_chance.dart';
import 'package:truemanradio/src/saveable/low_performance.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({
    Key? key,
    required this.adInfo,
    required this.lpInfo,
  }) : super(key: key);

  final LowPerformanceModeInfo lpInfo;
  final AdChanceInfo adInfo;

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width /
            MediaQuery.of(context).devicePixelRatio >
        700;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / (isDesktop ? 4 : 15),
      ),
      child: Dialog(
        backgroundColor: Colors.black.withOpacity(0.8),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Settings",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w200,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Low performance mode",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  StatefulBuilder(
                    builder: (context, setState) => Switch(
                      value: lpInfo.state == LowPerformanceModeState.enabled
                          ? true
                          : false,
                      onChanged: (v) => setState(
                        () => lpInfo.state = v
                            ? LowPerformanceModeState.enabled
                            : LowPerformanceModeState.disabled,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Ad chance",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  StatefulBuilder(
                    builder: (context, setState) => Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${adInfo.chance}%",
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Slider(
                            value: adInfo.chance / 100,
                            activeColor: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.5),
                            thumbColor: Theme.of(context).colorScheme.secondary,
                            inactiveColor: Colors.white.withOpacity(0.4),
                            onChanged: (v) => setState(
                              () => adInfo.chance = (v * 100).toInt(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Close",
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
