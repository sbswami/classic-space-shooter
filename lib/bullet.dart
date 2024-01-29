import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:spaceshooter/space_shooter.dart';

class Bullet extends SpriteComponent with HasGameRef<SpaceShooterGame> {
  Bullet({super.position}) : super(size: Vector2(28, 28), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite(
      'Bullet.png',
      srcSize: Vector2(28, 28),
    );
    angle = pi / 2;

    add(RectangleHitbox(collisionType: CollisionType.passive));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y += dt * -game.bulletSpeed;

    if (position.y < -height) {
      removeFromParent();
    }
    super.update(dt);
  }
}
