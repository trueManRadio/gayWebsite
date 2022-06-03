import 'dart:convert';

import 'package:dio/dio.dart';
import 'player.dart';

import 'package:flutter/services.dart' show rootBundle;

String baseUrl =
    "https://raw.githubusercontent.com/trueManRadio/audioStorage/master/";
String preAdSoundName = "preAd.mp3";
String postAdSoundName = "postAd.mp3";

void _logAndThrow(String text) {
  // ignore: avoid_print
  print("FATAL: $text");
  throw (text);
}

void _warning(String text) {
  // ignore: avoid_print
  print("WARNING: $text");
}

GayWave _waveFromString(String wave) {
  for (var i in GayWave.values) {
    if (i.toString() == wave) {
      return i;
    }
  }

  _warning("$wave NOT FOUND");
  return GayWave.gay;
}

class GayTrack {
  late String filename;
  late String name;
  late GayWave wave;

  GayTrack({
    required this.filename,
    required this.name,
    required this.wave,
  });

  GayTrack.fromJson(Map<String, dynamic> json) {
    if (json["filename"] != null) {
      filename = json["filename"];
    } else {
      _logAndThrow("Invalid track filename");
    }
    if (json["name"] != null) {
      name = json["name"];
    } else {
      name = "Unknown name";
      _warning("${json["filename"]} haven't got display name");
    }
    if (json["wave"] != null) {
      wave = _waveFromString(json["wave"]);
    } else {
      wave = GayWave.gay;
      _warning("${json["filename"]} haven't got wave");
    }
  }
}

class GayTracklist {
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

  Future<void> network() async {
    String data = await rootBundle.loadString('tracklist.json');

    json = jsonDecode(data);
    if (json.isEmpty) {
      _logAndThrow("Failed to parse tracklist");
    }

    adsPath = json["contents_path"]!["ads"]!["root"]! + "/";
    for (var i in Map<String, dynamic>.from(json["contents_path"]!).entries) {
      if (i.key == 'ads') continue;
      wavePath[_waveFromString(i.key)] = i.value + "/";
    }
    for (var i
        in Map<String, dynamic>.from(json["contents_path"]!["ads"]!).entries) {
      if (i.key == 'root') continue;
      adWaveSoundsPath[_waveFromString(i.key.replaceAll("_sounds", ""))] =
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
