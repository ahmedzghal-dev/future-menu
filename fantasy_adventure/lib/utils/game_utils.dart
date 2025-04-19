import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameUtils {
  // Singleton pattern
  static final GameUtils _instance = GameUtils._internal();
  factory GameUtils() => _instance;
  GameUtils._internal();
  
  final Random _random = Random();
  
  // Generate a random number within a range
  int getRandomInt(int min, int max) {
    return min + _random.nextInt(max - min + 1);
  }
  
  // Generate a random color with opacity
  Color getRandomColor({double opacity = 1.0}) {
    return Color.fromRGBO(
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
      opacity,
    );
  }
  
  // Save high score to persistent storage
  Future<void> saveHighScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    final currentHighScore = prefs.getInt('highScore') ?? 0;
    
    if (score > currentHighScore) {
      await prefs.setInt('highScore', score);
    }
  }
  
  // Load high score from persistent storage
  Future<int> loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('highScore') ?? 0;
  }
  
  // Calculate distance between two points
  double getDistance(double x1, double y1, double x2, double y2) {
    return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
  }
  
  // Format time in MM:SS format
  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
} 