import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final x;
  final y;
  final brickWidth;
  final color;
  MyBrick({this.x, this.y, this.brickWidth, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2 * x + brickWidth) / (2 - brickWidth), y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: color,
          height: 20,
          width: MediaQuery.of(context).size.width / 5,
        ),
      ),
    );
  }
}
