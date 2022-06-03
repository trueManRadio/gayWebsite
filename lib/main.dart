/*
 * Copyright (c) True Man Radio, 2022
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:truemanradio/main_page.dart';
import 'package:truemanradio/player.dart';

// There's nothing hard to do, so I was too lazy to use OOP...
// also I was too lazy to remove app template parts.....

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'True Man Radio',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GayTracklist>(
          create: (context) => GayTracklist(),
        ),
        ChangeNotifierProvider<GayPlayer>(
          create: (context) => GayPlayer(
            tracklist: context.read<GayTracklist>(),
          ),
        ),
      ],
      builder: (context, _) => FutureBuilder(
        future: context.read<GayTracklist>().network(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Failed to load tracklist"),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width / 4,
                            ),
                            child: SingleChildScrollView(
                              child: Text(
                                snapshot.error.toString(),
                                style: GoogleFonts.robotoMono(
                                  color: Colors.grey,
                                ),
                                maxLines: 9999,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const MainPage();
            }
          } else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    Text("Loading tracklist..."),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
