/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'package:flutter/material.dart';
import 'package:truemanradio/src/saveable/ad_chance.dart';
import 'package:truemanradio/src/saveable/low_performance.dart';
import 'package:truemanradio/src/main.dart';

void main() async {
  runApp(App(
    lastAdChance: await AdChanceInfo.getLastChance(),
    lastLpState: await LowPerformanceModeInfo.getLastState(),
  ));
}
