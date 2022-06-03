/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';
import 'tracklist.dart';
import 'player_types.dart';

export 'tracklist.dart';
export 'player_types.dart';

class _GayPlayerImpl {
  AudioPlayer? audioPlayer;

  Future<void> setupPlayer(String url, GayPlayer p) async {
    p.mp3 = url;

    if (audioPlayer!.state != PlayerState.stopped) {
      await audioPlayer!.stop();
    }

    await audioPlayer!.play(
      UrlSource(url),
      volume: p.volume,
      mode: PlayerMode.mediaPlayer,
    );
  }

  Future<void> setVolume(GayPlayer p) async {
    if (audioPlayer != null) {
      await audioPlayer!.setVolume(p.volume);
    }
  }

  Future<void> loadAd(GayPlayer p, String name) {
    return setupPlayer(baseUrl + p.tracklist.adsPath + name, p);
  }

  Future<void> loadPreAd(GayPlayer p) {
    return loadAd(p, p.tracklist.adWaveSoundsPath[p.wave]! + preAdSoundName);
  }

  Future<void> loadPostAd(GayPlayer p) {
    return loadAd(p, p.tracklist.adWaveSoundsPath[p.wave]! + postAdSoundName);
  }

  Future<void> loadMusic(GayPlayer p, String name) {
    return setupPlayer(baseUrl + p.tracklist.wavePath[p.wave]! + name, p);
  }

  void setPlayerCallback(Function(PlayerState) handler) {
    audioPlayer!.onPlayerStateChanged.listen(handler);
    audioPlayer!.onPlayerComplete.listen((event) {
      handler(PlayerState.stopped);
    });
  }

  void initPlayer() {
    audioPlayer = AudioPlayer();
  }
}

class GayPlayer extends ChangeNotifier {
  GayWave _currentWave = GayWave.none;
  GayPlayerEvent _event = GayPlayerEvent.loading;
  GayEventState _eventState = GayEventState.running;
  String _currentSong = "Loading...";
  double _volume = 0.7;
  final _GayPlayerImpl _impl = _GayPlayerImpl();
  final Map<GayWave, List<GayTrack>> _availableTracks = {};
  final List<String> _availableAds = [];
  GayTracklist tracklist;
  GayTrack? currentTrack;
  String errorText = "";
  String mp3 = "";

  AudioPlayer? get player => _impl.audioPlayer;

  void playerEventHandler(PlayerState pstate) {
    try {
      if (wave == GayWave.none) {
        return;
      }

      if (pstate == PlayerState.paused) {
        player!.resume();
        return;
      }

      if (pstate == PlayerState.stopped) {
        if (_event == GayPlayerEvent.song) {
          // Check will we play ad or not
          // Chance: 20%
          if (Random().nextInt(100) < 20) {
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
      player!.dispose().then(
        (value) {
          _event = GayPlayerEvent.error;
          _eventState = GayEventState.loading;
          song = "Failed to load track";
          errorText = e.toString();
        },
      );
    }
  }

  void runAd() {
    event = GayPlayerEvent.loading;

    // Non-annoying random
    if (_availableAds.isEmpty) {
      _availableAds.addAll(tracklist.ads);
    }
    String randomAd = _availableAds[Random().nextInt(_availableAds.length)];
    _availableAds.remove(randomAd);

    _impl.loadAd(this, randomAd);

    StreamSubscription? s;
    s = player!.onDurationChanged.listen((dur) {
      if (dur.inMilliseconds > 10 &&
          event != GayPlayerEvent.ad &&
          event != GayPlayerEvent.error) {
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
    s = player!.onDurationChanged.listen((dur) {
      if (dur.inMilliseconds > 10 &&
          event != GayPlayerEvent.postAd &&
          event != GayPlayerEvent.error) {
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
    s = player!.onDurationChanged.listen((dur) {
      if (dur.inMilliseconds > 10 &&
          event != GayPlayerEvent.preAd &&
          event != GayPlayerEvent.error) {
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
      _availableTracks[wave]!.addAll(tracklist.tracksByWaves[wave]!);
    }
    GayTrack randomTrack = _availableTracks[wave]![
        Random().nextInt(_availableTracks[wave]!.length)];
    _availableTracks[wave]!.remove(randomTrack);

    event = GayPlayerEvent.loading;
    _impl.loadMusic(
      this,
      randomTrack.filename,
    );

    StreamSubscription? s;
    s = player!.onDurationChanged.listen((dur) {
      if (dur.inMilliseconds > 10 &&
          event != GayPlayerEvent.song &&
          event != GayPlayerEvent.error) {
        currentTrack = GayTrack(
          filename: randomTrack.filename,
          name: randomTrack.name,
          wave: randomTrack.wave,
        );
        event = GayPlayerEvent.song;
        if (s != null) {
          s.cancel();
        }
      }
    });

    _impl.setPlayerCallback(playerEventHandler);
  }

  void _addWaveTracksIfNull(GayWave w) {
    if (_availableTracks[w] == null) {
      _availableTracks[w] = [...tracklist.tracksByWaves[w]!];
    }
  }

  void mainThread() {
    if (wave == GayWave.none) {
      return;
    }

    // Init non-annoying random
    if (_availableAds.isEmpty) {
      _availableAds.addAll(tracklist.ads);
    }
    _addWaveTracksIfNull(GayWave.gay);
    _addWaveTracksIfNull(GayWave.sadGay);
    _addWaveTracksIfNull(GayWave.trueGay);

    event = GayPlayerEvent.loading;
    state = GayEventState.loading;
    playerEventHandler(PlayerState.completed);
  }

  set wave(GayWave w) {
    _currentWave = w;
    waveNotifier.value = w;
    notifyListeners();

    player!.stop().then(
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
        _currentSong = "Loading...";
        break;
      case GayPlayerEvent.song:
        if (currentTrack != null) {
          if (kDebugMode) {
            _currentSong =
                "${currentTrack!.wave.toString()} | ${currentTrack!.name} (${currentTrack!.filename})";
          } else {
            _currentSong = currentTrack!.name;
          }
        } else {
          _currentSong = "Error (TRACK_INFO_WAS_NOT_PROVIDED)";
        }
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

  GayPlayer({required this.tracklist}) {
    _impl.initPlayer();
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
