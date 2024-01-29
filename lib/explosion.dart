import 'package:flame/components.dart';
import 'package:spaceshooter/space_shooter.dart';

class Explosion extends SpriteAnimationComponent with HasGameRef<SpaceShooterGame> {
  Explosion({super.position}) : super(size: Vector2(128, 128), anchor: Anchor.center, removeOnFinish: true);

  @override
  Future<void> onLoad() async {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('explosion.png'),
      SpriteAnimationData.sequenced(
        amount: 7,
        stepTime: 0.07,
        textureSize: Vector2(512, 512),
        loop: false,
      ),
    );
    return super.onLoad();
  }
}
