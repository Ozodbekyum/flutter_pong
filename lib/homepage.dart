import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pong/ball.dart';
import 'package:flutter_pong/brick.dart';
import 'package:flutter_pong/coverscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  double playerX = -0.2;
  double playerWidth = 0.4;
  double ballX = 0;
  double ballY = 0;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;

  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 16), (timer) {
      updateDirection();
      moveBall();
      if (isPlayerDead()) {
        timer.cancel();
        resetGame();
      }
    });
  }

  void resetGame() {
    setState(() {
      gameHasStarted = false;
      ballX = 0;
      ballY = 0;
      playerX = -0.2;
    });
  }

  bool isPlayerDead() {
    if (ballY <= -0.8) {
      return true;
    }
    return false;
  }

  void updateDirection() {
    setState(() {
      if (ballY >= 0.9 && playerX + playerWidth >= ballX && playerX <= ballX) {
        ballYDirection = direction.UP;
      } else if (ballY <= -0.9) {
        ballYDirection = direction.DOWN;
      }

      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      } else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }

  void moveBall() {
    setState(() {
      if (ballYDirection == direction.DOWN) {
        ballY += 0.01;
      } else if (ballYDirection == direction.UP) {
        ballY -= 0.01;
      }

      if (ballXDirection == direction.LEFT) {
        ballX -= 0.01;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += 0.01;
      }
    });
  }

  void moveLeft() {
    setState(() {
      playerX -= 0.1;
    });
  }

  void moveRight() {
    setState(() {
      playerX += 0.1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: startGame,
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
            moveLeft();
          } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
            moveRight();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          body: Center(
            child: Stack(
              children: [
                CoverScreen(
                  gameHasStarted: gameHasStarted,
                ),
                MyBrick(
                  x: 0,
                  y: -0.9,
                  brickWidth: playerWidth,
                  color: Colors.red,
                ),
                MyBrick(
                  x: playerX,
                  y: 0.9,
                  brickWidth: playerWidth,
                  color: Colors.blue,
                ),
                MyBall(
                  x: ballX,
                  y: ballY,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
