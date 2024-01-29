import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:spaceshooter/bullet.dart';
import 'package:spaceshooter/space_shooter.dart';

import 'explosion.dart';

class Asteroid extends SpriteAnimationComponent with CollisionCallbacks, HasGameRef<SpaceShooterGame> {
  static const asteroidSize = 64.0;

  Asteroid({super.position}) : super(size: Vector2(asteroidSize, asteroidSize), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Boost.png'),
      SpriteAnimationData.sequenced(
        amount: 5,
        stepTime: 0.1,
        textureSize: Vector2(192, 192),
      ),
    );

    angle = pi / 2;

    add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y += dt * game.enemySpeed;

    if (position.y > game.size.y) {
      removeFromParent();
    }
    super.update(dt);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bullet) {
      other.removeFromParent();
      removeFromParent();
      game.add(Explosion(position: position.clone()));
    }
  }
}
