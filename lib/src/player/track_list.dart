/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'dart:convert';
import 'package:truemanradio/src/misc/logging.dart';
import 'package:truemanradio/src/player/base.dart';

import 'package:flutter/services.dart' show rootBundle;

String baseUrl =
    "https://raw.githubusercontent.com/trueManRadio/audioStorage/master/";
String preAdSoundName = "preAd.mp3";
String postAdSoundName = "postAd.mp3";

class GayTrackList {
  List<GayTrack> tracks = [];
  List<String> ads = [];
  String adsPath = "";
  Map<GayWave, String> adWaveSoundsPath = {};
  Map<GayWave, String> wavePath = {};
  Map<String, dynamic> json = {};

  Map<GayWave, List<GayTrack>> get tracksByWaves {
    Map<GayWave, List<GayTrack>> ret = {};

    for (var i in tracks) {
      if (ret[i.wave] == null) {
        ret[i.wave] = [];
      }
      ret[i.wave]!.add(i);
    }

    return ret;
  }

  Future<void> load() async {
    String data = await rootBundle.loadString('assets/tracklist.json');

    json = jsonDecode(data);
    if (json.isEmpty) {
      loudlyThrow("Failed to parse tracklist");
    }

    adsPath = json["contents_path"]!["ads"]!["root"]! + "/";
    for (var i in Map<String, dynamic>.from(json["contents_path"]!).entries) {
      if (i.key == 'ads') continue;
      wavePath[i.key.toWave()] = i.value + "/";
    }
    for (var i
        in Map<String, dynamic>.from(json["contents_path"]!["ads"]!).entries) {
      if (i.key == 'root') continue;
      adWaveSoundsPath[i.key.replaceAll("_sounds", "").toWave()] =
          i.value + "/";
    }
    ads = List<String>.from(json["ads"]!);

    List<Map<String, dynamic>> jtracks =
        List<Map<String, dynamic>>.from(json["tracks"]);
    for (var i in jtracks) {
      tracks.add(GayTrack.fromJson(i));
    }
  }
}
