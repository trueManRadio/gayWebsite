/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truemanradio/src/saveable/ad_chance.dart';
import 'package:truemanradio/src/saveable/low_performance.dart';
import 'package:truemanradio/src/player/base.dart';
import 'package:truemanradio/src/widgets/appbar.dart';
import 'package:truemanradio/src/widgets/lp_notification.dart';
import 'package:truemanradio/src/widgets/player.dart';
import 'package:truemanradio/src/widgets/wave_selector.dart';
import 'package:video_player/video_player.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final Map<GayWave, VideoPlayerController> _controllers = {};

  Future<void> _initControllers() async {
    for (var c in _controllers.values) {
      await c.initialize();
      await c.setLooping(true);
      await c.setVolume(0);
      await c.play();
    }
  }

  @override
  void initState() {
    super.initState();

    for (var i in [...GayWave.values]..remove(GayWave.none)) {
      _controllers[i] = VideoPlayerController.asset(
        "assets/bg_${i.toString()}.mp4",
        videoPlayerOptions: VideoPlayerOptions(
          allowBackgroundPlayback: true,
        ),
      );
    }

    if (Provider.of<LowPerformanceModeInfo>(context, listen: false).state !=
        LowPerformanceModeState.enabled) {
      _initControllers();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width /
            MediaQuery.of(context).devicePixelRatio >
        700;

    if (context.read<LowPerformanceModeInfo>().state ==
        LowPerformanceModeState.waitingForUserDecision) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          (!isDesktop)
              ? showDialog(
                  context: context,
                  builder: (context) => LpNotificationDialog(
                    lpInfo: context.read<LowPerformanceModeInfo>(),
                  ),
                )
              : context.read<LowPerformanceModeInfo>().state =
                  LowPerformanceModeState.disabled;
        },
      );
    }

    return Scaffold(
      body: Consumer<LowPerformanceModeInfo>(
        builder: (context, info, _) {
          if (info.prevState == LowPerformanceModeState.enabled &&
              info.state == LowPerformanceModeState.disabled) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.black.withOpacity(0.85),
                  content: Row(
                    children: const [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          "Loading video backgrounds after low performance mode change, please wait...",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              );
              _initControllers()
                  // Trigger video reload
                  .then((value) => waveNotifier.value = waveNotifier.value);
            });
          }

          return SizedBox.expand(
            child: Stack(
              children: [
                info.state == LowPerformanceModeState.enabled
                    ? Image.asset(
                        "assets/gym.jpg",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      )
                    : AnimatedBuilder(
                        animation: waveNotifier,
                        builder: (context, _) => AnimatedSwitcher(
                          duration: const Duration(seconds: 1),
                          child: waveNotifier.value == GayWave.none
                              ? Image.asset(
                                  "assets/gym.jpg",
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                )
                              : SizedBox.expand(
                                  key: UniqueKey(),
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: SizedBox(
                                      width: _controllers[waveNotifier.value]!
                                          .value
                                          .size
                                          .width,
                                      height: _controllers[waveNotifier.value]!
                                          .value
                                          .size
                                          .height,
                                      child: VideoPlayer(
                                        _controllers[waveNotifier.value]!
                                          ..play(),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                Column(
                  children: [
                    (info.state == LowPerformanceModeState.enabled)
                        ? TrueManRadioAppBar(
                            adInfo: context.read<AdChanceInfo>(),
                            lpInfo: context.read<LowPerformanceModeInfo>(),
                          )
                        : ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 8.0,
                                sigmaY: 8.0,
                              ),
                              child: TrueManRadioAppBar(
                                adInfo: context.read<AdChanceInfo>(),
                                lpInfo: context.read<LowPerformanceModeInfo>(),
                              ),
                            ),
                          ),
                    Expanded(
                      child: Consumer<GayPlayer>(
                        builder: (context, player, child) => Column(
                          children: [
                            Expanded(
                              child:
                                  info.state == LowPerformanceModeState.enabled
                                      ? WaveSelectorWidget(
                                          player: player,
                                        )
                                      : ClipRect(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 5.0,
                                              sigmaY: 5.0,
                                            ),
                                            child: WaveSelectorWidget(
                                              player: player,
                                            ),
                                          ),
                                        ),
                            ),
                            player.wave != GayWave.none
                                ? PlayerWidget(player: player)
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
