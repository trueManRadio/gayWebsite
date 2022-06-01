import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:truemanradio/player.dart';
import 'package:truemanradio/player_widget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icon.svg",
              semanticsLabel: 'Logo',
              width: MediaQuery.of(context).size.height / 32,
              height: MediaQuery.of(context).size.height / 32,
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
                    "v1.1",
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
      body: SizedBox.expand(
        child: Stack(
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Image.asset(
                "assets/gym.jpg",
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(200),
                    ),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Consumer<GayPlayer>(
                          builder: (context, value, child) => Column(
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
                    ),
                  ),
                ),
                Consumer<GayPlayer>(
                  builder: (context, value, child) =>
                      (value.wave != GayWave.none)
                          ? PlayerWidget(player: value)
                          : Container(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
