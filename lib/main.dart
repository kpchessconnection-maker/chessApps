import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';

void main() {  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chess',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      // Start the app at the color selection screen
      home: const ColorSelectionScreen(),
    );
  }
}

// ==================================================================
// 1. Color Selection Screen
// ==================================================================
class ColorSelectionScreen extends StatelessWidget {
  const ColorSelectionScreen({super.key});

  // Function to navigate to the next screen, passing the chosen color
  void _selectColor(BuildContext context, PlayerColor color) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TimeSelectionScreen(selectedColor: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Chess'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose Your Color',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            // "Play as White" Button
            ElevatedButton(
              onPressed: () => _selectColor(context, PlayerColor.white),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(250, 70),
                textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              child: const Text('Play as White'),
            ),
            const SizedBox(height: 20),
            // "Play as Black" Button
            ElevatedButton(
              onPressed: () => _selectColor(context, PlayerColor.black),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(250, 70),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              child: const Text('Play as Black'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================================================================
// 2. Time Control Selection Screen
// ==================================================================
class TimeSelectionScreen extends StatelessWidget {
  final PlayerColor selectedColor;

  const TimeSelectionScreen({super.key, required this.selectedColor});

  // Function to navigate to the final game screen
  void _selectTime(BuildContext context, String timeControl) {
    // Use pushReplacement to avoid stacking menus infinitely
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => GameScreen(
          playerColor: selectedColor,
          timeControl: timeControl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Time Control'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose Time Control',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            // Time control buttons
            _buildTimeButton(context, '3 + 0'),
            const SizedBox(height: 20),
            _buildTimeButton(context, '5 + 0'),
            const SizedBox(height: 20),
            _buildTimeButton(context, '10 + 10'),
          ],
        ),
      ),
    );
  }

  // Helper widget to build the time buttons consistently
  Widget _buildTimeButton(BuildContext context, String time) {
    return ElevatedButton(
      onPressed: () => _selectTime(context, time),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 60),
        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      child: Text(time),
    );
  }
}

// ==================================================================
// 3. Game Screen
// ==================================================================
class GameScreen extends StatefulWidget {
  final PlayerColor playerColor;
  final String timeControl;

  const GameScreen({
    super.key,
    required this.playerColor,
    required this.timeControl,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final ChessBoardController _controller = ChessBoardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game: ${widget.timeControl}'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ChessBoard(
            controller: _controller,
            // The board is oriented based on the color chosen in the first menu
            boardOrientation: widget.playerColor,
            boardColor: BoardColor.green,
            // You can add onMove and other callbacks here later
          ),
        ),
      ),
    );
  }
}
