import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../components/player.dart';
import '../components/obstacle.dart';
import '../components/background.dart';
import '../components/hud.dart';
import '../components/powerup.dart';
import '../utils/drag_callbacks.dart' as utils;

enum GameState { playing, gameOver, paused }

class FantasyAdventureGame extends FlameGame 
    with HasCollisionDetection, HasKeyboardHandlerComponents, TapCallbacks {
  
  // Game components
  late Player player;
  late GameBackground background;
  late GameHud hud;
  
  // Game state
  GameState gameState = GameState.playing;
  int score = 0;
  int highScore = 0;
  double gameSpeed = 200;
  double _timeSinceLastObstacle = 0;
  double _timeSinceLastPowerUp = 0;
  String? activePowerUp;
  double powerUpTimeRemaining = 0;
  
  // Touch control variables
  bool _isTouchingLeft = false;
  bool _isTouchingRight = false;
  bool _isMobileDevice = false;
  
  // Randomness
  final Random _random = Random();
  
  // Obstacle generation parameters
  double minObstacleSpawnTime = 1.5;
  double maxObstacleSpawnTime = 3.0;
  double nextObstacleSpawn = 2.0;
  
  // PowerUp generation parameters
  double minPowerUpSpawnTime = 8.0;
  double maxPowerUpSpawnTime = 15.0;
  double nextPowerUpSpawn = 10.0;
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Detect if running on mobile
    _isMobileDevice = _detectMobileDevice();
    
    // Try to load the game sounds, but don't crash if they're missing
    try {
      await FlameAudio.audioCache.loadAll([
        'jump.mp3',
        'collect.mp3',
        'game_over.mp3',
        'background_music.mp3',
      ]);
      
      // Play background music (only if available)
      FlameAudio.bgm.play('background_music.mp3');
    } catch (e) {
      print('Warning: Audio files not found. Game will continue without sound.');
    }
    
    // Add scrolling background
    background = GameBackground(scrollSpeed: 50);
    add(background);
    
    // Add player
    player = Player();
    player.position = Vector2(size.x * 0.2, size.y - 100);
    add(player);
    
    // Add HUD
    hud = GameHud();
    add(hud);
    
    // Add mobile controls if on a mobile device
    if (_isMobileDevice) {
      overlays.add('mobile_controls');
    }
    
    // Add a drag detector component for mobile controls
    if (_isMobileDevice) {
      add(
        utils.CustomDragDetector(
          onStartDrag: _handleDragStart,
          onEndDrag: _handleDragEnd,
          onUpdateDrag: _handleDragUpdate,
        )
      );
    }
  }
  
  bool _detectMobileDevice() {
    if (kIsWeb) {
      return false; // Handle web differently if needed
    }
    try {
      return Platform.isAndroid || Platform.isIOS;
    } catch (e) {
      return false; // Default to desktop if detection fails
    }
  }
  
  void _handleDragStart(DragStartEvent event) {
    if (gameState != GameState.playing) return;
    
    final touchX = event.localPosition.x;
    if (touchX < size.x / 2) {
      _isTouchingLeft = true;
      _isTouchingRight = false;
    } else {
      _isTouchingLeft = false;
      _isTouchingRight = true;
    }
  }
  
  void _handleDragEnd(DragEndEvent event) {
    if (gameState != GameState.playing) return;
    
    _isTouchingLeft = false;
    _isTouchingRight = false;
  }
  
  void _handleDragUpdate(DragUpdateEvent event) {
    if (gameState != GameState.playing) return;
    
    // Update touch position
    final touchX = event.localPosition.x;
    if (touchX < size.x / 2) {
      _isTouchingLeft = true;
      _isTouchingRight = false;
    } else {
      _isTouchingLeft = false;
      _isTouchingRight = true;
    }
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    if (gameState == GameState.playing) {
      // Update score based on time
      score += (10 * dt).toInt();
      if (score > highScore) {
        highScore = score;
      }
      
      // Handle touch-based movement for mobile
      if (_isMobileDevice) {
        if (_isTouchingLeft) {
          player.moveLeft();
        } else if (_isTouchingRight) {
          player.moveRight();
        } else {
          player.stopMoving();
        }
      }
      
      // Increase game speed gradually
      gameSpeed = 200 + (score / 100);
      
      // Update PowerUp status
      if (activePowerUp != null && powerUpTimeRemaining > 0) {
        powerUpTimeRemaining -= dt;
        if (powerUpTimeRemaining <= 0) {
          _deactivatePowerUp();
        }
      }
      
      // Generate obstacles
      _timeSinceLastObstacle += dt;
      if (_timeSinceLastObstacle >= nextObstacleSpawn) {
        _spawnObstacle();
        _timeSinceLastObstacle = 0;
        nextObstacleSpawn = minObstacleSpawnTime + 
            _random.nextDouble() * (maxObstacleSpawnTime - minObstacleSpawnTime);
      }
      
      // Generate powerups
      _timeSinceLastPowerUp += dt;
      if (_timeSinceLastPowerUp >= nextPowerUpSpawn) {
        _spawnPowerUp();
        _timeSinceLastPowerUp = 0;
        nextPowerUpSpawn = minPowerUpSpawnTime + 
            _random.nextDouble() * (maxPowerUpSpawnTime - minPowerUpSpawnTime);
      }
      
      // Check for collisions
      _checkCollisions();
    }
  }
  
  void _checkCollisions() {
    // This is handled by Flame's collision detection system
  }
  
  void _spawnObstacle() {
    final obstacle = Obstacle(scrollSpeed: gameSpeed);
    add(obstacle);
  }
  
  void _spawnPowerUp() {
    final powerUp = PowerUp(
      scrollSpeed: gameSpeed,
      onCollected: _activateRandomPowerUp,
    );
    add(powerUp);
  }
  
  void _activateRandomPowerUp() {
    // Play sound safely
    try {
      FlameAudio.play('collect.mp3');
    } catch (e) {
      // Ignore audio errors
    }
    
    // Choose a random power-up
    final powerUpTypes = ['Speed Boost', 'Shield', 'Double Points'];
    activePowerUp = powerUpTypes[_random.nextInt(powerUpTypes.length)];
    powerUpTimeRemaining = 10.0; // 10 seconds duration
    
    // Apply power-up effect
    switch (activePowerUp) {
      case 'Speed Boost':
        player.speed = 300;
        break;
      case 'Shield':
        // Implement shield visual effect
        break;
      case 'Double Points':
        // Double points logic handled in score calculation
        break;
      default:
        // No effect for unknown powerup
        break;
    }
  }
  
  void _deactivatePowerUp() {
    // Reset power-up effects
    switch (activePowerUp) {
      case 'Speed Boost':
        player.speed = 200;
        break;
      case 'Shield':
        // Remove shield visual effect
        break;
      case 'Double Points':
        // No need to reset, just stop doubling points
        break;
      default:
        // No effect for unknown powerup
        break;
    }
    
    activePowerUp = null;
    powerUpTimeRemaining = 0;
  }
  
  void gameOver() {
    gameState = GameState.gameOver;
    try {
      FlameAudio.bgm.stop();
      FlameAudio.play('game_over.mp3');
    } catch (e) {
      // Ignore audio errors
    }
    
    // Display game over overlay
    final gameOverText = TextComponent(
      text: 'Game Over',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.red,
          fontSize: 48,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(offset: Offset(3, 3), blurRadius: 3, color: Colors.black),
          ],
        ),
      ),
      position: Vector2(size.x / 2, size.y / 2 - 50),
      anchor: Anchor.center,
    );
    add(gameOverText);
    
    final scoreText = TextComponent(
      text: 'Score: $score',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 32,
          shadows: [
            Shadow(offset: Offset(2, 2), blurRadius: 2, color: Colors.black),
          ],
        ),
      ),
      position: Vector2(size.x / 2, size.y / 2 + 10),
      anchor: Anchor.center,
    );
    add(scoreText);
    
    final tapToRestartText = TextComponent(
      text: 'Tap to restart',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      position: Vector2(size.x / 2, size.y / 2 + 60),
      anchor: Anchor.center,
    );
    add(tapToRestartText);
  }
  
  void reset() {
    // Remove all game components
    removeAll(children);
    
    // Reset game state
    gameState = GameState.playing;
    score = 0;
    gameSpeed = 200;
    _timeSinceLastObstacle = 0;
    _timeSinceLastPowerUp = 0;
    activePowerUp = null;
    powerUpTimeRemaining = 0;
    _isTouchingLeft = false;
    _isTouchingRight = false;
    
    // Reload all components
    onLoad();
  }
  
  @override
  void onTapUp(TapUpEvent event) {
    if (gameState == GameState.gameOver) {
      reset();
    } else if (gameState == GameState.playing) {
      player.jump();
      try {
        FlameAudio.play('jump.mp3');
      } catch (e) {
        // Ignore audio errors
      }
    }
  }
  
  // For desktop and web
  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (gameState == GameState.gameOver && 
        event is KeyDownEvent && 
        event.logicalKey == LogicalKeyboardKey.space) {
      reset();
      return KeyEventResult.handled;
    }
    
    return KeyEventResult.ignored;
  }
  
  // Game utility function to get current game time
  double currentTime() {
    return overlays.isActive('pause_menu') ? 0.0 : 0.1;
  }
} 