/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:truemanradio/src/player/base.dart';

class GayPlayerImpl {
  AudioPlayer? audioPlayer;
  GayPlayer player;

  Future<void> setupPlayer(String url) async {
    player.mp3 = url;

    if (audioPlayer!.state != PlayerState.stopped) {
      await audioPlayer!.stop();
    }

    await audioPlayer!.play(
      UrlSource(url),
      volume: player.volume,
      mode: PlayerMode.mediaPlayer,
    );
  }

  Future<void> dispose() {
    return audioPlayer!.dispose();
  }

  Future<void> stop() {
    return audioPlayer!.stop();
  }

  Future<void> updateVolume() async {
    if (audioPlayer != null) {
      await audioPlayer!.setVolume(player.volume);
    }
  }

  Future<void> loadAd(String name) {
    return setupPlayer(baseUrl + player.trackList.adsPath + name);
  }

  Future<void> loadPreAd() {
    return loadAd(
        player.trackList.adWaveSoundsPath[player.wave]! + preAdSoundName);
  }

  Future<void> loadPostAd() {
    return loadAd(
        player.trackList.adWaveSoundsPath[player.wave]! + postAdSoundName);
  }

  Future<void> loadMusic(String name) {
    return setupPlayer(
        baseUrl + player.trackList.wavePath[player.wave]! + name);
  }

  void setPlayerCallback(Function(PlayerState) handler) {
    audioPlayer!.onPlayerStateChanged.listen(handler);
    audioPlayer!.onPlayerComplete.listen((event) {
      handler(PlayerState.stopped);
    });
  }

  StreamSubscription<Duration> setDurationCallback(Function(Duration) handler) {
    return audioPlayer!.onDurationChanged.listen(handler);
  }

  void initPlayer() {
    audioPlayer = AudioPlayer();
  }

  GayPlayerImpl({required this.player});
}
