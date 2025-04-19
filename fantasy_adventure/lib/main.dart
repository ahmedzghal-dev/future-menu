import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'fantasy_game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fantasy Adventure',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'PixeloidSans',
      ),
      home: const GameHomePage(),
    );
  }
}

class GameHomePage extends StatelessWidget {
  const GameHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: FantasyGame(),
        loadingBuilder: (context) => const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                  strokeWidth: 8.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Loading Adventure...',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'PixeloidSans',
                ),
              ),
            ],
          ),
        ),
        errorBuilder: (context, error) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                'An error occurred:\n$error',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontFamily: 'PixeloidSans',
                ),
              ),
            ],
          ),
        ),
        overlayBuilderMap: {
          'pause_button': (_, game) => Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(Icons.pause, color: Colors.white, size: 32),
                  onPressed: () {
                    // Implementation for pause button
                  },
                ),
              ),
        },
      ),
    );
  }
}
