// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io' show Platform;
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../managers/managers.dart';
//import '../world.dart';
import '../doodle_dash.dart';
import 'widgets.dart';
import '../sprites/player.dart';

class GameOverlay extends StatefulWidget {
  const GameOverlay(this.game,{super.key});

  final Game game;
  //late Player player;
  //Player player;
  @override
  State<GameOverlay> createState() => GameOverlayState();
}

class GameOverlayState extends State<GameOverlay> {
  bool isPaused = false;
  bool isRestart=false;
  final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);
  //final World _world = World();
  late Player player;
  late  GameManager gameManager;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea (
        child: Stack(
          children: [
            Positioned(
              top: 30,
              left: 30,
              child: ScoreDisplay(game: widget.game),
            ),
            Positioned(
              top: 90,
              right: 30,
              child: ElevatedButton(
                child: const Icon(
                  Icons.refresh,
                  size: 48,
                ),
                onPressed: () {
                  (widget.game as DoodleDash).onrestart();

                  },
                  
                  ),
            ),
            Positioned(
              top: 30,
              right: 30,
              child: ElevatedButton(
                child: isPaused
                    ? const Icon(
                        Icons.play_arrow,
                        size: 48,
                      )
                    : const Icon(
                        Icons.pause,
                        size: 48,
                      ),
                onPressed: () {
                  (widget.game as DoodleDash).togglePauseState();
                  setState(
                    () {
                      isPaused = !isPaused;
                    },
                  );
                },
              ),
            ),
          
            if (isMobile)
              Positioned(
                bottom: MediaQuery.of(context).size.height / 4,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: GestureDetector(
                          onTapDown: (details) {
                            (widget.game as DoodleDash).player.moveLeft(); //audio
                          },
                          onTapUp: (details) {
                            (widget.game as DoodleDash).player.resetDirection();//audio
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: 3.0,
                            shadowColor: Theme.of(context).colorScheme.background,
                            child: const Icon(Icons.arrow_left, size: 64),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: GestureDetector(
                          onTapDown: (details) {
                            (widget.game as DoodleDash).player.moveRight();//audio
                          },
                          onTapUp: (details) {
                            (widget.game as DoodleDash).player.resetDirection();//audio
                          },
                          child: Material(
                            color: Colors.transparent,
                            elevation: 3.0,
                            shadowColor: Theme.of(context).colorScheme.background,
                            child: const Icon(Icons.arrow_right, size: 64),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (isRestart)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 72.0,
              right: MediaQuery.of(context).size.height / 2 - 72.0,
              
                child: const Icon(
                  Icons.refresh,
                  size: 48,
                  color: Colors.black12,
                ),
            ),




              


            if (isPaused)
              Positioned(
                top: MediaQuery.of(context).size.height / 2 - 72.0,
                right: MediaQuery.of(context).size.width / 2 - 72.0,
                child: const Icon(
                  Icons.pause_circle,
                  size: 144.0,
                  color: Colors.black12,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
