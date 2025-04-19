import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import '../game/fantasy_adventure_game.dart';
import 'player.dart';

class PowerUp extends SpriteComponent with HasGameRef<FantasyAdventureGame>, CollisionCallbacks {
  
  final double scrollSpeed;
  final Function onCollected;
  final Random _random = Random();
  bool _isCollected = false;
  
  // PowerUp types
  static const List<String> _powerUpTypes = [
    'powerup_gem.png',
    'powerup_potion.png',
    'powerup_star.png',
  ];
  
  PowerUp({required this.scrollSpeed, required this.onCollected}) : super(size: Vector2(48, 48));
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Select a random powerup type
    final powerUpType = _powerUpTypes[_random.nextInt(_powerUpTypes.length)];
    sprite = await game.loadSprite(powerUpType);
    
    // Set initial position at the right edge of the screen at a random height
    position = Vector2(
      game.size.x + size.x,
      game.size.y * (0.3 + 0.5 * _random.nextDouble()),
    );
    
    // Add collision hitbox
    add(
      CircleHitbox(
        radius: 20,
        position: Vector2(24, 24),
        anchor: Anchor.center,
      ),
    );
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Oscillate up and down for visual effect
    position.y += sin(game.currentTime() * 5) * 0.5;
    
    // Move from right to left
    position.x -= scrollSpeed * dt;
    
    // Remove if off screen
    if (position.x < -size.x) {
      removeFromParent();
    }
  }
  
  @override
  void onCollisionStart(Set<Vector2> points, PositionComponent other) {
    super.onCollisionStart(points, other);
    
    if (other is Player && !_isCollected) {
      _isCollected = true;
      onCollected();
      removeFromParent();
    }
  }
} 