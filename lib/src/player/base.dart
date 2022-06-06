/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:truemanradio/src/saveable/ad_chance.dart';
import 'package:truemanradio/src/player/track_list.dart';
import 'package:truemanradio/src/player/impl.dart';
import 'package:truemanradio/src/player/types.dart';

export 'package:truemanradio/src/player/track_list.dart';
export 'package:truemanradio/src/player/types.dart';

class GayPlayer extends ChangeNotifier {
  GayWave _currentWave = GayWave.none;
  GayPlayerEvent _event = GayPlayerEvent.loading;
  GayEventState _eventState = GayEventState.running;
  String _currentSong = "Loading...";
  double _volume = 0.7;
  late final GayPlayerImpl _impl;
  final Map<GayWave, List<GayTrack>> _availableTracks = {};
  final List<String> _availableAds = [];
  GayTrackList trackList;
  AdChanceInfo adChance;
  GayTrack? currentTrack;
  String errorText = "";
  String mp3 = "";
  int? _lastSubKey;

  AudioPlayer? get player => _impl.audioPlayer;

  void playerEventHandler(PlayerState pstate) {
    try {
      if (wave == GayWave.none) {
        return;
      }

      if (pstate == PlayerState.stopped) {
        if (_event == GayPlayerEvent.song) {
          // Check will we play ad or not
          if (Random().nextInt(100 + 1) < adChance.chance) {
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
      } else if ((_event == GayPlayerEvent.loading ||
              _event == GayPlayerEvent.error) &&
          state != GayEventState.running) {
        // First run case
        state = GayEventState.running;
        runMusic();
        return;
      }
    } catch (e) {
      _impl.dispose().then(
        (value) {
          _eventState = GayEventState.loading;
          errorText = e.toString();
          event = GayPlayerEvent.error;
        },
      );
    }
  }

  void _addPostLoadingAction(GayPlayerEvent ev) {
    int thisSubKey = Random().nextInt(9999999);
    _lastSubKey = thisSubKey;

    StreamSubscription? s;
    s = _impl.setDurationCallback((dur) {
      if ((_lastSubKey ?? thisSubKey) == thisSubKey &&
          dur.inMilliseconds > 10 &&
          event != ev &&
          event != GayPlayerEvent.error) {
        event = ev;
        if (s != null) s.cancel();
      }
    });
  }

  void runAd() {
    event = GayPlayerEvent.loading;

    // Non-annoying random
    if (_availableAds.isEmpty) {
      _availableAds.addAll(trackList.ads);
    }
    String randomAd = _availableAds[Random().nextInt(_availableAds.length)];
    _availableAds.remove(randomAd);

    _impl.loadAd(randomAd);
    _addPostLoadingAction(GayPlayerEvent.ad);
  }

  void runPostAd() {
    event = GayPlayerEvent.loading;
    _impl.loadPostAd();
    _addPostLoadingAction(GayPlayerEvent.postAd);
  }

  void runPreAd() {
    event = GayPlayerEvent.loading;
    _impl.loadPreAd();
    _addPostLoadingAction(GayPlayerEvent.preAd);
  }

  void runMusic() {
    // Non-annoying random
    if (_availableTracks[wave]!.isEmpty) {
      _availableTracks[wave]!.addAll(trackList.tracksByWaves[wave]!);
    }
    GayTrack randomTrack = _availableTracks[wave]![
        Random().nextInt(_availableTracks[wave]!.length)];

    currentTrack = GayTrack(
      filename: randomTrack.filename,
      name: randomTrack.name,
      wave: randomTrack.wave,
    );

    _availableTracks[wave]!.remove(randomTrack);

    event = GayPlayerEvent.loading;

    _impl.loadMusic(randomTrack.filename);

    _addPostLoadingAction(GayPlayerEvent.song);
  }

  void _addWaveTracksIfNull(GayWave w) {
    if (_availableTracks[w] == null) {
      _availableTracks[w] = [...trackList.tracksByWaves[w]!];
    }
  }

  void mainThread() {
    if (wave == GayWave.none) {
      return;
    }

    // Init non-annoying random
    if (_availableAds.isEmpty) {
      _availableAds.addAll(trackList.ads);
    }
    _addWaveTracksIfNull(GayWave.gay);
    _addWaveTracksIfNull(GayWave.sadGay);
    _addWaveTracksIfNull(GayWave.trueGay);

    event = GayPlayerEvent.loading;
    state = GayEventState.loading;
    playerEventHandler(PlayerState.completed);
  }

  String getPlayerText() {
    if (event != GayPlayerEvent.song) {
      if (kDebugMode) {
        return "${wave.toString()}, ${state.toString()} | $song";
      } else {
        return song;
      }
    }

    if (kDebugMode) {
      return "${currentTrack!.wave.toString()} | ${currentTrack!.name} (${currentTrack!.filename})";
    } else {
      return currentTrack!.name;
    }
  }

  set wave(GayWave w) {
    _currentWave = w;
    waveNotifier.value = w;
    notifyListeners();

    _impl.stop().then(
          (_) => Future.sync(
            () => mainThread(),
          ),
        );
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
      case GayPlayerEvent.song:
        _currentSong = "Loading...";
        break;
      case GayPlayerEvent.error:
        _currentSong = "Failed to load track";
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
    _impl.updateVolume();
    notifyListeners();
  }

  GayPlayer({
    required this.trackList,
    required this.adChance,
  }) {
    _impl = GayPlayerImpl(player: this);
    _impl.initPlayer();
    _impl.setPlayerCallback(playerEventHandler);
  }

  double get volume => _volume;
  GayWave get wave => _currentWave;
  GayPlayerEvent get event => _event;
  String get song => _currentSong;
  GayEventState get state => _eventState;
}

class GayWaveNotifier extends ChangeNotifier {
  GayWave _wave = GayWave.none;
  GayWave get value => _wave;
  set value(GayWave w) {
    _wave = w;
    notifyListeners();
  }
}

GayWaveNotifier waveNotifier = GayWaveNotifier();
