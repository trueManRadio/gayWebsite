// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:truemanradio/low_performance.dart';
import 'package:truemanradio/player.dart';
import 'package:truemanradio/player_widget.dart';
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

  final bool _visible = true;

  @override
  Widget build(BuildContext context) {
    bool isDesktop = MediaQuery.of(context).size.width /
            MediaQuery.of(context).devicePixelRatio >
        700;

    LowPerformanceModeInfo lpInfo = context.read<LowPerformanceModeInfo>();
    if (lpInfo.state == LowPerformanceModeState.waitingForUserDecision) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        (!isDesktop)
            ? showDialog(
                context: context,
                builder: (context) => Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width /
                        (isDesktop ? 4 : 15),
                  ),
                  child: Dialog(
                    backgroundColor: Colors.black.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Enable low performance mode?",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w200,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "It's a way to improve performance on low-end or middle-end mobile devices. Video backgrounds, blur and some animations will be disabled. You can change this in settings.",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OutlinedButton(
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all(
                                    const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  lpInfo.state =
                                      LowPerformanceModeState.disabled;
                                },
                                child: const Text(
                                  "Disable",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  lpInfo.state =
                                      LowPerformanceModeState.enabled;
                                },
                                child: const Text(
                                  "Enable",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : lpInfo.state = LowPerformanceModeState.disabled;
      });
    }

    Widget appBarContainer = Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.85),
      ),
      child: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(
                Icons.telegram,
                color: Colors.white.withOpacity(0.4),
              ),
              onPressed: () {
                js.context.callMethod(
                  "open",
                  ["https://t.me/truemanradio"],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white.withOpacity(0.4),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width /
                          (isDesktop ? 4 : 15),
                    ),
                    child: Dialog(
                      backgroundColor: Colors.black.withOpacity(0.8),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Settings",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w200,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Low performance mode",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                StatefulBuilder(
                                  builder: (context, setState) => Switch(
                                    value: lpInfo.state ==
                                            LowPerformanceModeState.enabled
                                        ? true
                                        : false,
                                    onChanged: (v) => setState(
                                      () => lpInfo.state = v
                                          ? LowPerformanceModeState.enabled
                                          : LowPerformanceModeState.disabled,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Close",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icon.svg",
                    semanticsLabel: 'Logo',
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.5),
                      ],
                      end: Alignment.bottomLeft,
                      begin: Alignment.topRight,
                    ).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "TRUE MAN RADIO",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Text(
                          "v2.0${kDebugMode ? "-debug" : ""}",
                          style: GoogleFonts.roboto(
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    Widget mainWidget = Stack(
      children: [
        Consumer<GayPlayer>(
          builder: (context, value, child) {
            if (value.event == GayPlayerEvent.error &&
                value.state == GayEventState.loading) {
              WidgetsBinding.instance.addPostFrameCallback(
                (timeStamp) {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Error while loading track",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Error text"),
                            Text(value.errorText,
                                style: GoogleFonts.robotoMono()),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Debug info"),
                            Text("State: ${value.state.toString()}"),
                            Text("Event: ${value.event.toString()}"),
                            Text("Song name: ${value.song}"),
                            Text("mp3: ${value.mp3}"),
                            Text("Wave: ${value.wave}"),
                            Text("Volume: ${value.volume.toStringAsFixed(2)}"),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                                "Please reload page to continue listening"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            return Column(
              children: [
                Expanded(
                  child: (_visible)
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.65),
                          ),
                          child: Center(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Choose your gay wave:",
                                    style: GoogleFonts.roboto(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                    onPressed: (value.wave == GayWave.gay)
                                        ? null
                                        : () {
                                            value.wave = GayWave.gay;
                                          },
                                    child: Text(
                                      "GAY",
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 36,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                    onPressed: (value.wave == GayWave.trueGay)
                                        ? null
                                        : () {
                                            value.wave = GayWave.trueGay;
                                          },
                                    child: Text(
                                      "TRUE GAY",
                                      style: GoogleFonts.oswald(
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 36,
                                        color: Colors.purpleAccent,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                    onPressed: (value.wave == GayWave.sadGay)
                                        ? null
                                        : () {
                                            value.wave = GayWave.sadGay;
                                          },
                                    child: Text(
                                      "sad gay...",
                                      style: GoogleFonts.qwigley(
                                        fontWeight: FontWeight.w200,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 36,
                                        color: Colors.blue.shade200,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                    onPressed: (value.wave == GayWave.none)
                                        ? null
                                        : () {
                                            value.wave = GayWave.none;
                                          },
                                    child: Text(
                                      "None",
                                      style: GoogleFonts.roboto(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w200,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
                Consumer<GayPlayer>(
                  builder: (context, value, child) =>
                      (value.wave != GayWave.none)
                          ? PlayerWidget(player: value)
                          : Container(),
                ),
              ],
            );
          },
        ),
      ],
    );

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
                        ? appBarContainer
                        : ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 8.0,
                                sigmaY: 8.0,
                              ),
                              child: appBarContainer,
                            ),
                          ),
                    Expanded(
                      child: (info.state == LowPerformanceModeState.enabled)
                          ? mainWidget
                          : ClipRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 5.0,
                                  sigmaY: 5.0,
                                ),
                                child: mainWidget,
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
