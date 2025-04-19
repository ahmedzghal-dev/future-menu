import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../game/fantasy_adventure_game.dart';
import 'player.dart';

class Obstacle extends SpriteComponent with HasGameRef<FantasyAdventureGame>, CollisionCallbacks {
  
  final double scrollSpeed;
  final Random _random = Random();
  
  // Obstacle types
  static const List<String> _obstacleTypes = [
    'obstacle_crystal.png',
    'obstacle_tree.png',
    'obstacle_rock.png',
  ];
  
  Obstacle({required this.scrollSpeed}) : super(size: Vector2(48, 64));
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Select a random obstacle type
    final obstacleType = _obstacleTypes[_random.nextInt(_obstacleTypes.length)];
    sprite = await game.loadSprite(obstacleType);
    
    // Set initial position at the right edge of the screen
    position = Vector2(
      game.size.x + size.x,
      game.size.y - 32 - size.y / 2,
    );
    
    // Add collision hitbox
    add(
      RectangleHitbox(
        size: Vector2(40, 60),
        position: Vector2(4, 2),
        isSolid: true,
      ),
    );
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Move the obstacle from right to left
    position.x -= scrollSpeed * dt;
    
    // Remove if off screen
    if (position.x < -size.x) {
      removeFromParent();
    }
  }
}

class PowerUp extends SpriteComponent with HasGameRef<FantasyAdventureGame>, CollisionCallbacks {
  
  final double scrollSpeed;
  static const List<String> _powerupTypes = [
    'powerup_gem.png',
    'powerup_potion.png',
    'powerup_star.png',
  ];
  
  final Random _random = Random();
  final Function onCollected;
  
  PowerUp({required this.scrollSpeed, required this.onCollected}) 
      : super(size: Vector2(32, 32), anchor: Anchor.center);
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Select a random powerup type
    final powerupType = _powerupTypes[_random.nextInt(_powerupTypes.length)];
    sprite = await game.loadSprite(powerupType);
    
    // Set random y position on the right side of the screen
    position = Vector2(
      game.size.x + size.x,
      game.size.y - _random.nextInt(250) - 100,
    );
    
    // Add circular hitbox for collection
    add(
      CircleHitbox(
        radius: 15,
        position: size / 2,
        isSolid: false,
      ),
    );
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Move the powerup from right to left
    position.x -= scrollSpeed * dt;
    
    // Add floating effect
    position.y += sin(game.currentTime() * 5) * 0.5;
    
    // Remove if off screen
    if (position.x < -size.x) {
      removeFromParent();
    }
  }
  
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    
    if (other is Player) {
      onCollected();
      removeFromParent();
    }
  }
} 