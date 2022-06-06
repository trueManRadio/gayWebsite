/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LowPerformanceModeState {
  waitingForUserDecision,
  disabled,
  enabled,
}

class LowPerformanceModeInfo extends ChangeNotifier {
  LowPerformanceModeState _state =
      LowPerformanceModeState.waitingForUserDecision;
  List<LowPerformanceModeState> _statesHistory = [];

  LowPerformanceModeState get state => _state;
  LowPerformanceModeState get prevState =>
      _statesHistory[_statesHistory.length - 2];

  set state(LowPerformanceModeState state) {
    if (state != LowPerformanceModeState.waitingForUserDecision) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool(
          "low_performance",
          state == LowPerformanceModeState.enabled,
        );
      });
    }

    _statesHistory.add(state);

    _state = state;
    notifyListeners();
  }

  static Future<LowPerformanceModeState> getLastState() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("low_performance")) {
      bool? val = prefs.getBool("low_performance");
      if (val != null) {
        return val
            ? LowPerformanceModeState.enabled
            : LowPerformanceModeState.disabled;
      }
    }

    return LowPerformanceModeState.waitingForUserDecision;
  }

  LowPerformanceModeInfo(LowPerformanceModeState initialState) {
    _state = initialState;
    _statesHistory = [
      initialState,
      initialState,
    ];
  }
}
