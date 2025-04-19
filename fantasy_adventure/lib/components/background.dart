import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import '../game/fantasy_adventure_game.dart';

class GameBackground extends PositionComponent with HasGameRef<FantasyAdventureGame> {
  
  final double scrollSpeed;
  Color skyColor = Colors.transparent;
  Color mountainColor = Colors.transparent;
  
  GameBackground({required this.scrollSpeed}) : super(priority: -1);
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Set background size to match game screen
    size = game.size;
    
    // Create parallax layers for the background
    final parallaxImages = [
      ParallaxImageData('background_sky.png'),
      ParallaxImageData('background_mountains.png'),
      ParallaxImageData('background_trees.png'),
      ParallaxImageData('background_ground.png'),
    ];
    
    final parallax = await Parallax.load(
      parallaxImages,
      baseVelocity: Vector2(scrollSpeed, 0),
      velocityMultiplierDelta: Vector2(1.0, 0.0),
      repeat: ImageRepeat.repeatX,
      fill: LayerFill.height,
    );
    
    add(ParallaxComponent.fromParallax(
      parallax,
      size: size,
    ));
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Update background colors based on player's score
    _updateBackgroundBasedOnScore();
  }
  
  void _updateBackgroundBasedOnScore() {
    final score = game.score;
    
    // Change background colors based on score to create different moods
    if (score > 5000) {
      // Night theme (purple-ish)
      skyColor = Colors.indigo.withOpacity(0.3);
      mountainColor = Colors.purple.withOpacity(0.2);
    } else if (score > 3000) {
      // Evening theme (orange-ish)
      skyColor = Colors.orange.withOpacity(0.2);
      mountainColor = Colors.deepOrange.withOpacity(0.1);
    } else if (score > 1000) {
      // Day theme (blue-ish)
      skyColor = Colors.lightBlue.withOpacity(0.1);
      mountainColor = Colors.transparent;
    } else {
      // Morning theme (default, no overlay)
      skyColor = Colors.transparent;
      mountainColor = Colors.transparent;
    }
  }
  
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    // Draw a colored rectangle over the entire background to create mood
    if (skyColor != Colors.transparent) {
      canvas.drawRect(
        Rect.fromLTWH(0, 0, size.x, size.y / 2),
        Paint()..color = skyColor,
      );
    }
    
    if (mountainColor != Colors.transparent) {
      canvas.drawRect(
        Rect.fromLTWH(0, size.y / 2, size.x, size.y / 2),
        Paint()..color = mountainColor,
      );
    }
  }
} 