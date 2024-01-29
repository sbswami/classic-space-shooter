import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame/parallax.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:spaceshooter/player.dart';

import 'asteroid.dart';

class SpaceShooterGame extends FlameGame with PanDetector, HasCollisionDetection {
  late Player player;
  double bulletSpeed = 500;
  double enemySpeed = 100;

  // @override
  // Color backgroundColor() => const Color(0xFF356193);
  @override
  Color backgroundColor() => const Color(0xFF555555);

  @override
  Future<void> onLoad() async {
    await images.loadAll(['Idle.png', 'Move.png', "Bullet.png", "asteroid.png", "explosion.png", "Boost.png"]);
    await _addParallax();
    await _addEnemies();

    player = Player();

    add(player);

    return super.onLoad();
  }

  Future<void> _addParallax() async {
    final parallaxComponent = await loadParallaxComponent(
      [
        ParallaxImageData('stars.png'),
        ParallaxImageData('stars.png'),
        ParallaxImageData('stars.png'),
      ],
      baseVelocity: Vector2(0, -5),
      repeat: ImageRepeat.repeat,
      velocityMultiplierDelta: Vector2(0, 3),
    );

    add(parallaxComponent);
  }

  Future<void> _addEnemies() async {
    final SpawnComponent asteroidSpawner = SpawnComponent(
      period: 1.0,
      factory: (index) {
        return Asteroid();
      },
      area: Rectangle.fromLTWH(0, 0, size.x, -Asteroid.asteroidSize),
    );

    add(asteroidSpawner);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    player.move(info.delta.global);
    super.onPanUpdate(info);
  }

  @override
  void onPanStart(DragStartInfo info) {
    player.shoot();
    super.onPanStart(info);
  }

  @override
  void onPanEnd(DragEndInfo info) {
    player.stop();
    super.onPanEnd(info);
  }
}
