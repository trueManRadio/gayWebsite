/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kplayer/kplayer.dart';
import 'tracklist.dart';

enum GayWave {
  gay,
  trueGay,
  sadGay,
  none,
}

enum GayPlayerEvent {
  loading,
  song,
  preAd,
  ad,
  postAd,
}

enum GayEventState {
  loading,
  running,
}

String _baseUrl =
    "https://raw.githubusercontent.com/trueManRadio/audioStorage/master/";
Map<GayWave, String> _waveUrl = {
  GayWave.none: "",
  GayWave.gay: "gay/",
  GayWave.sadGay: "sadGay/",
  GayWave.trueGay: "trueGay/",
};
String _adsUrl = "ads/";
String _preAdSoundName = "preAd.mp3";
String _postAdSoundName = "postAd.mp3";
Map<GayWave, String> _waveAdPartsUrl = {
  GayWave.none: "",
  GayWave.gay: "gaySounds/",
  GayWave.sadGay: "sadGaySounds/",
  GayWave.trueGay: "trueGaySounds/",
};

class _GayPlayerImpl {
  PlayerController? lastPlayer;

  void stopLastPlayer() {
    if (lastPlayer != null) {
      lastPlayer!.dispose();
    }
    lastPlayer = null;
  }

  void setupPlayer(String url, GayPlayer p) {
    lastPlayer = Player.network(url, autoPlay: false);
    lastPlayer!.volume = p.volume;
    lastPlayer!.init();
    lastPlayer!.play();
  }

  void setVolume(GayPlayer p) {
    if (lastPlayer != null) {
      lastPlayer!.volume = p.volume;
    }
  }

  void loadAd(GayPlayer p, String name) {
    stopLastPlayer();
    setupPlayer(_baseUrl + _adsUrl + name, p);
  }

  void loadPreAd(GayPlayer p) {
    loadAd(p, _waveAdPartsUrl[p.wave]! + _preAdSoundName);
  }

  void loadPostAd(GayPlayer p) {
    loadAd(p, _waveAdPartsUrl[p.wave]! + _postAdSoundName);
  }

  void loadMusic(GayPlayer p, String name) {
    stopLastPlayer();
    setupPlayer(_baseUrl + _waveUrl[p.wave]! + name, p);
  }

  void setPlayerCallback(Function(PlayerEvent) handler) {
    lastPlayer!.callback = handler;
  }
}

class GayPlayer extends ChangeNotifier {
  GayWave _currentWave = GayWave.none;
  GayPlayerEvent _event = GayPlayerEvent.loading;
  GayEventState _eventState = GayEventState.running;
  String _currentSong = "Loading...";
  double _volume = 0.7;
  final _GayPlayerImpl _impl = _GayPlayerImpl();
  final Map<GayWave, List<String>> _availableTracks = {};
  final List<String> _availableAds = [];

  PlayerController? get player => _impl.lastPlayer;

  void playerEventHandler(PlayerEvent event) {
    if (event == PlayerEvent.status &&
        _impl.lastPlayer!.status == PlayerStatus.ended) {
      if (wave == GayWave.none) {
        return;
      }

      if (_event == GayPlayerEvent.song) {
        // Check will we play ad or not
        if (Random().nextBool()) {
          runPreAd();
        } else {
          runMusic();
        }
        return;
      }

      if (_event == GayPlayerEvent.preAd) {
        runAd();
        return;
      }

      if (_event == GayPlayerEvent.ad) {
        runPostAd();
        return;
      }

      if (_event == GayPlayerEvent.postAd) {
        runMusic();
        return;
      }
    } else if (_event == GayPlayerEvent.loading &&
        state != GayEventState.running) {
      // First run case
      state = GayEventState.running;
      runMusic();
      return;
    }
  }

  void runAd() {
    event = GayPlayerEvent.loading;

    // Non-annoying random
    if (_availableAds.isEmpty) {
      _availableAds.addAll(adContents);
    }
    String randomAd = _availableAds[Random().nextInt(_availableAds.length)];
    _availableAds.remove(randomAd);

    _impl.loadAd(this, randomAd);

    StreamSubscription? s;
    s = _impl.lastPlayer!.streams.status.listen((pevent) {
      if (_impl.lastPlayer!.duration.inMilliseconds > 10 &&
          event != GayPlayerEvent.ad) {
        event = GayPlayerEvent.ad;
        if (s != null) {
          s.cancel();
        }
      }
    });

    _impl.setPlayerCallback(playerEventHandler);
  }

  void runPostAd() {
    event = GayPlayerEvent.loading;
    _impl.loadPostAd(
      this,
    );

    StreamSubscription? s;
    s = _impl.lastPlayer!.streams.status.listen((pevent) {
      if (_impl.lastPlayer!.duration.inMilliseconds > 10 &&
          event != GayPlayerEvent.postAd) {
        event = GayPlayerEvent.postAd;
        if (s != null) {
          s.cancel();
        }
      }
    });

    _impl.setPlayerCallback(playerEventHandler);
  }

  void runPreAd() {
    event = GayPlayerEvent.loading;
    _impl.loadPreAd(
      this,
    );

    StreamSubscription? s;
    s = _impl.lastPlayer!.streams.status.listen((pevent) {
      if (_impl.lastPlayer!.duration.inMilliseconds > 10 &&
          event != GayPlayerEvent.preAd) {
        event = GayPlayerEvent.preAd;
        if (s != null) {
          s.cancel();
        }
      }
    });

    _impl.setPlayerCallback(playerEventHandler);
  }

  void runMusic() {
    // Non-annoying random
    if (_availableTracks[wave]!.isEmpty) {
      _availableTracks[wave]!.addAll(waveContents[wave]!);
    }
    String randomTrack = _availableTracks[wave]![
        Random().nextInt(_availableTracks[wave]!.length)];
    _availableTracks[wave]!.remove(randomTrack);

    event = GayPlayerEvent.loading;
    _impl.loadMusic(
      this,
      randomTrack,
    );

    StreamSubscription? s;
    s = _impl.lastPlayer!.streams.status.listen((pevent) {
      if (_impl.lastPlayer!.duration.inMilliseconds > 10 &&
          event != GayPlayerEvent.song) {
        event = GayPlayerEvent.song;
        song = trackNames[randomTrack]!;
        if (s != null) {
          s.cancel();
        }
      }
    });

    _impl.setPlayerCallback(playerEventHandler);
  }

  void _addWaveTracksIfNull(GayWave w) {
    if (_availableTracks[w] == null) {
      _availableTracks[w] = [...waveContents[w]!];
    }
  }

  void mainThread() {
    if (wave == GayWave.none) {
      return;
    }

    // Init non-annoying random
    _availableAds.addAll(adContents);
    _addWaveTracksIfNull(GayWave.gay);
    _addWaveTracksIfNull(GayWave.sadGay);
    _addWaveTracksIfNull(GayWave.trueGay);

    event = GayPlayerEvent.loading;
    state = GayEventState.loading;
    playerEventHandler(PlayerEvent.load);
  }

  set wave(GayWave w) {
    _currentWave = w;
    notifyListeners();

    _impl.stopLastPlayer();
    Future.sync(() => mainThread());
  }

  set event(GayPlayerEvent w) {
    _event = w;

    switch (w) {
      case GayPlayerEvent.preAd:
        _currentSong = "Get ready for ad!";
        break;
      case GayPlayerEvent.ad:
        _currentSong = "Gay ad time";
        break;
      case GayPlayerEvent.postAd:
        _currentSong = "Music will continue soon";
        break;
      case GayPlayerEvent.loading:
        _currentSong = "Loading...";
        break;
      case GayPlayerEvent.song:
        // We do not want to change song name if it's already set
        break;
    }
    notifyListeners();
  }

  set song(String s) {
    _currentSong = s;
    notifyListeners();
  }

  set state(GayEventState s) {
    _eventState = s;
    notifyListeners();
  }

  set volume(double d) {
    _volume = d;
    _impl.setVolume(this);
    notifyListeners();
  }

  double get volume => _volume;
  GayWave get wave => _currentWave;
  GayPlayerEvent get event => _event;
  String get song => _currentSong;
  GayEventState get state => _eventState;
}
