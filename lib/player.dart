import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:spaceshooter/bullet.dart';
import 'package:spaceshooter/space_shooter.dart';

enum ActionType { idle, move }

class Player extends SpriteAnimationGroupComponent<ActionType> with HasGameRef<SpaceShooterGame> {
  late final SpawnComponent _spawnComponent;

  Player({super.position}) : super(size: Vector2(128, 128), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    final idleAnimation = _createAnimation('Idle.png', 8, 0.1);
    final moveAnimation = _createAnimation('Move.png', 6, 0.1);

    animations = {
      ActionType.idle: idleAnimation,
      ActionType.move: moveAnimation,
    };

    angle = -pi / 2;
    position = game.size / 2;
    current = ActionType.move;

    _spawnComponent = SpawnComponent(
      period: 0.2,
      selfPositioning: true,
      factory: (index) {
        final bullet = Bullet(
          position: position + Vector2(0, -size.y / 2),
        );
        return bullet;
      },
      autoStart: false,
    );

    game.add(_spawnComponent);

    return super.onLoad();
  }

  SpriteAnimation _createAnimation(String imageName, int amount, double stepTime) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache(imageName),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2(192, 192),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  Vector2 velocity = Vector2.zero();

  void move(Vector2 delta) {
    velocity = position.clone();
    velocity.add(delta);
    if (velocity.x <= 0 || velocity.x >= game.size.x || velocity.y <= 0 || velocity.y >= game.size.y) return;
    position.add(delta * 2);
  }

  void shoot() {
    _spawnComponent.timer.start();
    current = ActionType.idle;
  }

  void stop() {
    current = ActionType.move;
    _spawnComponent.timer.stop();
  }
}
