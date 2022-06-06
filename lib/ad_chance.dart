import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdChanceInfo {
  static const int defaultChance = 20;
  int _chance = defaultChance;

  int get chance => _chance;

  set chance(int c) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt("ad_random_chance", c);
    });

    _chance = c;
  }

  static Future<int> getLastChance() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("ad_random_chance")) {
      int? val = prefs.getInt("ad_random_chance");
      if (val != null) {
        return val;
      }
    }

    return defaultChance;
  }

  AdChanceInfo({required int lastChance}) {
    chance = lastChance;
  }
}
