import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class SimpleGame extends FlameGame with TapCallbacks {
  late TextComponent scoreText;
  int score = 0;
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Add a background color
    add(
      RectangleComponent(
        size: size,
        paint: Paint()..color = Colors.lightBlue,
      ),
    );
    
    // Add a player sprite (a simple square for now)
    final player = RectangleComponent(
      size: Vector2(50, 50),
      position: size / 2,
      anchor: Anchor.center,
      paint: Paint()..color = Colors.red,
    );
    add(player);
    
    // Add some obstacles
    for (int i = 0; i < 5; i++) {
      final obstacle = RectangleComponent(
        size: Vector2(30, 30),
        position: Vector2(
          size.x * (0.2 + i * 0.15),
          size.y * 0.7,
        ),
        anchor: Anchor.center,
        paint: Paint()..color = Colors.green,
      );
      add(obstacle);
    }
    
    // Add score text
    scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(20, 20),
      textRenderer: TextPaint(
        style: const TextStyle(
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
    
    // Add instructions
    final instructions = TextComponent(
      text: 'Tap the screen to increase score',
      position: Vector2(size.x / 2, size.y - 50),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
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
    add(instructions);
  }
  
  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    score++;
    scoreText.text = 'Score: $score';
  }
} 