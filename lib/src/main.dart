/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'package:flutter/material.dart';
import 'package:truemanradio/src/pages/preload.dart';
import 'package:truemanradio/src/saveable/low_performance.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.lastAdChance,
    required this.lastLpState,
  }) : super(key: key);

  final int lastAdChance;
  final LowPerformanceModeState lastLpState;

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
      home: PreloadPage(
        lastAdChance: lastAdChance,
        lastLpState: lastLpState,
      ),
    );
  }
}
