/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:truemanradio/src/saveable/low_performance.dart';

class LpNotificationDialog extends StatelessWidget {
  const LpNotificationDialog({
    Key? key,
    required this.lpInfo,
  }) : super(key: key);

  final LowPerformanceModeInfo lpInfo;

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
              Text(
                "Enable low performance mode?",
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w200,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "It's a way to improve performance on low-end or middle-end mobile devices. Video backgrounds, blur and some animations will be disabled. You can change this in settings.",
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      lpInfo.state = LowPerformanceModeState.disabled;
                    },
                    child: const Text(
                      "Disable",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      lpInfo.state = LowPerformanceModeState.enabled;
                    },
                    child: const Text(
                      "Enable",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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
