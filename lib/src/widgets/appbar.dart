/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:truemanradio/src/saveable/ad_chance.dart';
import 'package:truemanradio/src/saveable/low_performance.dart';
import 'package:truemanradio/src/widgets/settings_dialog.dart';

class TrueManRadioAppBar extends StatelessWidget {
  const TrueManRadioAppBar({
    Key? key,
    required this.adInfo,
    required this.lpInfo,
  }) : super(key: key);

  final LowPerformanceModeInfo lpInfo;
  final AdChanceInfo adInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.85),
      ),
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(
                Icons.telegram,
                color: Colors.white.withOpacity(0.4),
              ),
              onPressed: () {
                js.context.callMethod(
                  "open",
                  ["https://t.me/truemanradio"],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white.withOpacity(0.4),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => SettingsDialog(
                    adInfo: adInfo,
                    lpInfo: lpInfo,
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icon.svg",
                    semanticsLabel: 'Logo',
                    width: 16,
                    height: 16,
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "TRUE MAN RADIO",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          "v2.0${kDebugMode ? "-debug" : ""}",
                          style: GoogleFonts.roboto(
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
