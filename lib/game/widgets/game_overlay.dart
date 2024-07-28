// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io' show Platform;
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../doodle_dash.dart';
import 'widgets.dart';

class GameOverlay extends StatefulWidget {
  const GameOverlay(this.game, {super.key});

  final Game game;

  @override
  State<GameOverlay> createState() => GameOverlayState();
}

class GameOverlayState extends State<GameOverlay> {
  bool isPaused = false;
  final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, left: 30),
                      child: ScoreDisplay(game: widget.game),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, right: 30),
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
                  ],
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
            if (isMobile)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTapDown: (details) {
                          (widget.game as DoodleDash).player.moveLeft();
                        },
                        onTapUp: (details) {
                          (widget.game as DoodleDash).player.resetDirection();
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Material(
                                color: Colors.transparent,
                                elevation: 3.0,
                                shadowColor:
                                    Theme.of(context).colorScheme.background,
                                child: const Icon(Icons.arrow_left, size: 64),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                          color: Colors.transparent), // Inactive center area
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTapDown: (details) {
                          (widget.game as DoodleDash).player.moveRight();
                        },
                        onTapUp: (details) {
                          (widget.game as DoodleDash).player.resetDirection();
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 24),
                              child: Material(
                                color: Colors.transparent,
                                elevation: 3.0,
                                shadowColor:
                                    Theme.of(context).colorScheme.background,
                                child: const Icon(Icons.arrow_right, size: 64),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
