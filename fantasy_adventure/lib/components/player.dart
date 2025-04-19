import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import '../game/fantasy_adventure_game.dart';
import 'obstacle.dart';

enum PlayerState { idle, running, jumping, falling }

class Player extends SpriteAnimationGroupComponent<PlayerState> 
    with HasGameRef<FantasyAdventureGame>, KeyboardHandler, CollisionCallbacks {
  
  double speed = 200;
  final double gravity = 900;
  final double jumpForce = 450;
  
  Vector2 velocity = Vector2.zero();
  bool isOnGround = false;
  bool hasJumped = false;
  
  Player() : super(size: Vector2(64, 64), anchor: Anchor.center);
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Setup animations (would be replaced with actual sprite animations)
    final idleAnimation = SpriteAnimation.spriteList(
      [await game.loadSprite('player_idle.png')], 
      stepTime: 0.1
    );
    
    final runningAnimation = SpriteAnimation.spriteList(
      [await game.loadSprite('player_run.png')], 
      stepTime: 0.1
    );
    
    final jumpingAnimation = SpriteAnimation.spriteList(
      [await game.loadSprite('player_jump.png')], 
      stepTime: 0.1
    );
    
    final fallingAnimation = SpriteAnimation.spriteList(
      [await game.loadSprite('player_fall.png')], 
      stepTime: 0.1
    );
    
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
      PlayerState.jumping: jumpingAnimation,
      PlayerState.falling: fallingAnimation,
    };
    
    current = PlayerState.idle;
    
    // Add collision hitbox
    add(
      RectangleHitbox(
        size: Vector2(50, 60),
        position: Vector2(7, 2),
        isSolid: true,
      ),
    );
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Apply gravity
    velocity.y += gravity * dt;
    
    // Apply velocity
    position.x += velocity.x * dt;
    position.y += velocity.y * dt;
    
    // Keep player within screen bounds
    if (position.x < size.x / 2) {
      position.x = size.x / 2;
    } else if (position.x > game.size.x - size.x / 2) {
      position.x = game.size.x - size.x / 2;
    }
    
    // Check if player is on the ground
    if (position.y >= game.size.y - 36) {
      position.y = game.size.y - 36;
      velocity.y = 0;
      isOnGround = true;
      hasJumped = false;
    } else {
      isOnGround = false;
    }
    
    // Update animation state
    if (!isOnGround) {
      if (velocity.y < 0) {
        current = PlayerState.jumping;
      } else {
        current = PlayerState.falling;
      }
    } else if (velocity.x.abs() > 0) {
      current = PlayerState.running;
    } else {
      current = PlayerState.idle;
    }
  }
  
  void moveLeft() {
    velocity.x = -speed;
  }
  
  void moveRight() {
    velocity.x = speed;
  }
  
  void stopMoving() {
    velocity.x = 0;
  }
  
  void jump() {
    if (isOnGround && !hasJumped) {
      velocity.y = -jumpForce;
      hasJumped = true;
    }
  }
  
  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // Handle movement with arrow keys
    final isLeftPressed = keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightPressed = keysPressed.contains(LogicalKeyboardKey.arrowRight);
    final isSpacePressed = keysPressed.contains(LogicalKeyboardKey.space);
    
    // Reset horizontal velocity
    if (!isLeftPressed && !isRightPressed) {
      stopMoving();
    }
    
    // Move left
    if (isLeftPressed && !isRightPressed) {
      moveLeft();
    }
    
    // Move right
    if (isRightPressed && !isLeftPressed) {
      moveRight();
    }
    
    // Jump
    if (isSpacePressed && isOnGround && !hasJumped) {
      jump();
    }
    
    // Handle key up to stop jumping
    if (event is KeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.space) {
        if (velocity.y < 0) {
          velocity.y *= 0.5; // Cut jump height if space is released
        }
      }
    }
    
    return true;
  }
  
  @override
  void onCollisionStart(Set<Vector2> points, PositionComponent other) {
    super.onCollisionStart(points, other);
    
    // Handle collision with obstacles
    if (other is Obstacle) {
      game.gameOver();
    }
  }
} 