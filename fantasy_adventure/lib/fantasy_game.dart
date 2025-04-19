import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

class FantasyGame extends FlameGame with TapCallbacks, KeyboardEvents {
  // Game components
  late final SpriteAnimationComponent player;
  final List<SpriteComponent> obstacles = [];
  final List<SpriteComponent> powerups = [];
  
  // Game state
  int score = 0;
  bool isGameOver = false;
  bool isJumping = false;
  final double gravity = 0.3;
  final double jumpForce = -15;
  double verticalVelocity = 0;
  late double playerStartY;
  
  // UI components
  late TextComponent scoreText;
  late TextComponent gameOverText;
  late TextComponent instructionsText;
  
  // Sprite animations
  late SpriteAnimation idleAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation fallAnimation;
  
  // Obstacle and powerup types
  final List<String> obstacleTypes = ['crystal', 'tree', 'rock'];
  final List<String> powerupTypes = ['gem', 'potion', 'star'];
  
  // Random generator
  final Random random = Random();
  
  // Timer for spawning obstacles and powerups
  double obstacleTimer = 0;
  double powerupTimer = 0;
  final double obstacleSpawnRate = 2.0; // seconds
  final double powerupSpawnRate = 5.0; // seconds
  
  // Class variables for background scrolling
  late SpriteComponent mountainsBackground;
  late SpriteComponent treesBackground;
  late SpriteComponent groundBackground;
  
  // Scroll speeds
  final mountainsScrollSpeed = 30.0;
  final treesScrollSpeed = 60.0;
  final groundScrollSpeed = 120.0;
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Load audio
    try {
      await FlameAudio.audioCache.loadAll([
        'jump.mp3', 
        'collect.mp3.mp3', 
        'game_over.mp3', 
        'background_music.mp3'
      ]);
    } catch (e) {
      print('Error loading audio: $e');
    }
    
    // Don't play background music yet - wait for user interaction
    // We'll play it on first tap
    
    // Add a solid color background first
    add(
      RectangleComponent(
        size: size,
        paint: Paint()..color = Colors.lightBlue.shade200,
      ),
    );
    
    // Add sky background
    final skySprite = await Sprite.load('background_sky.png');
    final skyBackground = SpriteComponent(
      sprite: skySprite,
      size: Vector2(size.x, size.y),
      position: Vector2(0, 0),
    );
    add(skyBackground);
    
    // Add mountains (positioned at bottom)
    final mountainsSprite = await Sprite.load('background_mountains.png');
    mountainsBackground = SpriteComponent(
      sprite: mountainsSprite,
      size: Vector2(size.x * 1.5, size.y * 0.5),
      position: Vector2(0, size.y - size.y * 0.5),
    );
    add(mountainsBackground);
    
    // Add trees (positioned at bottom)
    final treesSprite = await Sprite.load('background_trees.png');
    treesBackground = SpriteComponent(
      sprite: treesSprite,
      size: Vector2(size.x * 1.5, size.y * 0.3),
      position: Vector2(0, size.y - size.y * 0.3),
    );
    add(treesBackground);
    
    // Add ground (positioned at bottom)
    final groundSprite = await Sprite.load('background_ground.png');
    groundBackground = SpriteComponent(
      sprite: groundSprite,
      size: Vector2(size.x * 2, size.y * 0.2),
      position: Vector2(0, size.y - size.y * 0.2),
    );
    add(groundBackground);
    
    // Load player animations with correct sizes
    idleAnimation = await SpriteAnimation.load(
      'player_idle.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2(64, 64),
        stepTime: 0.1,
      ),
    );
    
    runAnimation = await SpriteAnimation.load(
      'player_run.png',
      SpriteAnimationData.sequenced(
        amount: 6,
        textureSize: Vector2(64, 64),
        stepTime: 0.1,
      ),
    );
    
    jumpAnimation = await SpriteAnimation.load(
      'player_jump.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2(64, 64),
        stepTime: 0.1,
      ),
    );
    
    fallAnimation = await SpriteAnimation.load(
      'player_fall.png',
      SpriteAnimationData.sequenced(
        amount: 2,
        textureSize: Vector2(64, 64),
        stepTime: 0.1,
      ),
    );
    
    // Create player
    player = SpriteAnimationComponent(
      animation: runAnimation,
      position: Vector2(size.x * 0.2, size.y - size.y * 0.22),
      size: Vector2(100, 100),
      anchor: Anchor.bottomCenter,
    );
    add(player);
    
    playerStartY = player.position.y;
    
    // Add score text
    scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(20, 20),
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: 'PixeloidSans',
          fontSize: 24,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(2, 2),
              blurRadius: 2,
            ),
          ],
        ),
      ),
    );
    add(scoreText);
    
    // Create game over text (initially hidden)
    gameOverText = TextComponent(
      text: 'Game Over! Tap to restart',
      position: Vector2(size.x / 2, size.y / 2),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: 'PixeloidSans',
          fontSize: 32,
          color: Colors.red,
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(3, 3),
              blurRadius: 3,
            ),
          ],
        ),
      ),
    );
    gameOverText.removeFromParent();
    
    // Add instructions
    instructionsText = TextComponent(
      text: 'Tap to jump and avoid obstacles!',
      position: Vector2(size.x / 2, size.y - 50),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontFamily: 'PixeloidSans',
          fontSize: 20,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black,
              offset: Offset(1, 1),
              blurRadius: 1,
            ),
          ],
        ),
      ),
    );
    add(instructionsText);
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    if (isGameOver) return;
    
    // Scroll background layers
    _scrollBackground(dt);
    
    // Increment score
    score += (dt * 10).toInt();
    scoreText.text = 'Score: $score';
    
    // Apply gravity if jumping
    if (isJumping) {
      verticalVelocity += gravity;
      player.position.y += verticalVelocity;
      
      // Change animation based on velocity
      if (verticalVelocity < 0) {
        player.animation = jumpAnimation;
      } else {
        player.animation = fallAnimation;
      }
      
      // Check if player has landed
      if (player.position.y >= playerStartY) {
        player.position.y = playerStartY;
        isJumping = false;
        player.animation = runAnimation;
      }
    }
    
    // Update obstacle timer and spawn new obstacles
    obstacleTimer += dt;
    if (obstacleTimer >= obstacleSpawnRate) {
      obstacleTimer = 0;
      spawnObstacle();
    }
    
    // Update powerup timer and spawn new powerups
    powerupTimer += dt;
    if (powerupTimer >= powerupSpawnRate) {
      powerupTimer = 0;
      spawnPowerup();
    }
    
    // Move and check collisions with obstacles
    for (int i = obstacles.length - 1; i >= 0; i--) {
      final obstacle = obstacles[i];
      obstacle.position.x -= 200 * dt; // Move obstacles to the left
      
      // Check for collision with player
      if (checkCollision(player, obstacle: obstacle)) {
        gameOver();
      }
      
      // Remove obstacles that have moved off-screen
      if (obstacle.position.x < -obstacle.size.x) {
        obstacle.removeFromParent();
        obstacles.removeAt(i);
      }
    }
    
    // Move and check collisions with powerups
    for (int i = powerups.length - 1; i >= 0; i--) {
      final powerup = powerups[i];
      powerup.position.x -= 150 * dt; // Move powerups to the left
      
      // Check for collision with player
      if (checkCollision(player, obstacle: null, powerup: powerup)) {
        try {
          FlameAudio.play('collect.mp3.mp3');
        } catch (e) {
          print('Error playing collect sound: $e');
        }
        score += 50;
        powerup.removeFromParent();
        powerups.removeAt(i);
      }
      
      // Remove powerups that have moved off-screen
      if (powerup.position.x < -powerup.size.x) {
        powerup.removeFromParent();
        powerups.removeAt(i);
      }
    }
  }
  
  void _scrollBackground(double dt) {
    // Scroll mountains
    mountainsBackground.position.x -= mountainsScrollSpeed * dt;
    if (mountainsBackground.position.x <= -mountainsBackground.size.x / 3) {
      mountainsBackground.position.x = 0;
    }
    
    // Scroll trees
    treesBackground.position.x -= treesScrollSpeed * dt;
    if (treesBackground.position.x <= -treesBackground.size.x / 3) {
      treesBackground.position.x = 0;
    }
    
    // Scroll ground
    groundBackground.position.x -= groundScrollSpeed * dt;
    if (groundBackground.position.x <= -groundBackground.size.x / 3) {
      groundBackground.position.x = 0;
    }
  }
  
  void spawnObstacle() async {
    String type = obstacleTypes[random.nextInt(obstacleTypes.length)];
    final sprite = await loadSprite('obstacle_$type.png');
    
    double scale = 1.0;
    switch (type) {
      case 'crystal':
        scale = 0.8;
        break;
      case 'tree':
        scale = 1.2;
        break;
      case 'rock':
        scale = 0.9;
        break;
    }
    
    final obstacle = SpriteComponent(
      sprite: sprite,
      position: Vector2(size.x + 50, size.y - size.y * 0.22),
      size: Vector2(70, 70) * scale,
      anchor: Anchor.bottomCenter,
    );
    
    add(obstacle);
    obstacles.add(obstacle);
  }
  
  void spawnPowerup() async {
    String type = powerupTypes[random.nextInt(powerupTypes.length)];
    final sprite = await loadSprite('powerup_$type.png');
    
    final powerup = SpriteComponent(
      sprite: sprite,
      position: Vector2(
        size.x + 50,
        size.y - size.y * 0.3 - random.nextDouble() * (size.y * 0.2),
      ),
      size: Vector2(40, 40),
      anchor: Anchor.center,
    );
    
    add(powerup);
    powerups.add(powerup);
  }
  
  bool checkCollision(SpriteAnimationComponent player, {SpriteComponent? obstacle, SpriteComponent? powerup}) {
    final component = obstacle ?? powerup;
    if (component == null) return false;
    
    // Create smaller collision boxes for more forgiving collisions
    final playerBox = Rect.fromCenter(
      center: Offset(player.position.x, player.position.y - player.size.y * 0.3),
      width: player.size.x * 0.5,
      height: player.size.y * 0.5,
    );
    
    final componentBox = Rect.fromCenter(
      center: Offset(component.position.x, component.position.y - component.size.y * 0.3),
      width: component.size.x * 0.7,
      height: component.size.y * 0.7,
    );
    
    return playerBox.overlaps(componentBox);
  }
  
  void gameOver() {
    isGameOver = true;
    try {
      FlameAudio.bgm.stop();
      FlameAudio.play('game_over.mp3');
    } catch (e) {
      print('Error with game over audio: $e');
    }
    add(gameOverText);
    player.animation = idleAnimation;
  }
  
  void restart() {
    // Reset game state
    isGameOver = false;
    isJumping = false;
    score = 0;
    verticalVelocity = 0;
    player.position.y = playerStartY;
    player.animation = runAnimation;
    
    // Remove game over text
    gameOverText.removeFromParent();
    
    // Clear obstacles and powerups
    for (final obstacle in obstacles) {
      obstacle.removeFromParent();
    }
    obstacles.clear();
    
    for (final powerup in powerups) {
      powerup.removeFromParent();
    }
    powerups.clear();
    
    // Reset timers
    obstacleTimer = 0;
    powerupTimer = 0;
  }
  
  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    
    // Try to play background music on first tap if it's not playing
    if (!FlameAudio.bgm.isPlaying) {
      try {
        FlameAudio.bgm.play('background_music.mp3');
      } catch (e) {
        print('Error playing background music: $e');
      }
    }
    
    if (isGameOver) {
      restart();
      return;
    }
    
    if (!isJumping) {
      isJumping = true;
      verticalVelocity = jumpForce;
      try {
        FlameAudio.play('jump.mp3');
      } catch (e) {
        print('Error playing jump sound: $e');
      }
    }
  }
} 