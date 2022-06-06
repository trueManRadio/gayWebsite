/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'package:truemanradio/src/misc/logging.dart';

enum GayWave {
  gay,
  trueGay,
  sadGay,
  none,
}

enum GayPlayerEvent {
  loading,
  error,
  song,
  preAd,
  ad,
  postAd,
}

enum GayEventState {
  loading,
  running,
}

extension GayWaveString on String {
  GayWave toWave() {
    for (var i in GayWave.values) {
      if (i.toString() == this) {
        return i;
      }
    }

    printWarning("$this wave not found");
    return GayWave.gay;
  }
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
      loudlyThrow("Invalid track filename");
    }
    if (json["name"] != null) {
      name = json["name"];
    } else {
      name = "Unknown name";
      printWarning("${json["filename"]} haven't got display name");
    }
    if (json["wave"] != null) {
      wave = (json["wave"] as String).toWave();
    } else {
      wave = GayWave.gay;
      printWarning("${json["filename"]} haven't got wave");
    }
  }
}
