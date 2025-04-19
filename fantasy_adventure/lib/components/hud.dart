import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../game/fantasy_adventure_game.dart';

class GameHud extends PositionComponent with HasGameRef<FantasyAdventureGame> {
  
  late TextComponent _scoreText;
  late TextComponent _highScoreText;
  late TextComponent _powerUpText;
  
  GameHud() : super(priority: 20);
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Set position to top-left of the screen
    position = Vector2(20, 20);
    
    // Score text component
    _scoreText = TextComponent(
      text: 'Score: 0',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          shadows: [
            Shadow(offset: Offset(2, 2), blurRadius: 2, color: Colors.black),
          ],
        ),
      ),
    );
    add(_scoreText);
    
    // High score text component
    _highScoreText = TextComponent(
      text: 'High Score: 0',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.amber,
          fontSize: 16,
          shadows: [
            Shadow(offset: Offset(1, 1), blurRadius: 1, color: Colors.black),
          ],
        ),
      ),
      position: Vector2(0, 30),
    );
    add(_highScoreText);
    
    // PowerUp text component
    _powerUpText = TextComponent(
      text: '',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.greenAccent,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(offset: Offset(1, 1), blurRadius: 1, color: Colors.black),
          ],
        ),
      ),
      position: Vector2(0, 60),
    );
    add(_powerUpText);
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Update score text
    _scoreText.text = 'Score: ${game.score}';
    
    // Update high score text
    _highScoreText.text = 'High Score: ${game.highScore}';
    
    // PowerUp status
    if (game.activePowerUp != null && game.powerUpTimeRemaining > 0) {
      _powerUpText.text = '${game.activePowerUp}: ${game.powerUpTimeRemaining.toStringAsFixed(1)}s';
    } else {
      _powerUpText.text = '';
    }
  }
} 