import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:spaceshooter/space_shooter.dart';

void main() {
  runApp(
    const GameWidget<SpaceShooterGame>.controlled(
      gameFactory: SpaceShooterGame.new,
    ),
  );
}
