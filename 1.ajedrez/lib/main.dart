import 'package:flutter/material.dart';

void main() {
  runApp(const MyChessGame());
}

class MyChessGame extends StatelessWidget {
  const MyChessGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tablero de ajedrez'),
          backgroundColor: Colors.blueGrey,
        ),
        body: const BoardView(),
      ),
    );
  }
}

class GameBoard {
  final int gridSize;
  final Map<String, String> pieces = {};

  GameBoard({this.gridSize = 8});

  void placePiece(String type, String location) {
    pieces[location] = type;
  }

  void removePiece(String location) {
    pieces.remove(location);
  }

  String? getPieceAt(String location) {
    return pieces[location];
  }

  bool isPositionValid(String location) {
    if (location.length != 2) return false;
    String column = location[0];
    String row = location[1];
    return 'a'.codeUnitAt(0) <= column.codeUnitAt(0) &&
        column.codeUnitAt(0) < 'a'.codeUnitAt(0) + gridSize &&
        '1'.codeUnitAt(0) <= row.codeUnitAt(0) &&
        row.codeUnitAt(0) < '1'.codeUnitAt(0) + gridSize;
  }
}

class BoardView extends StatefulWidget {
  const BoardView({Key? key}) : super(key: key);

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {
  final GameBoard gameBoard = GameBoard();
  String? selectedPiece;
  String? selectedLocation;

  @override
  void initState() {
    super.initState();

    // Colocar todas las piezas iniciales en el tablero
    const backRank = ['♜', '♞', '♝', '♛', '♚', '♝', '♞', '♜'];
    const pawns = '♟';

    for (int i = 0; i < 8; i++) {
      gameBoard.placePiece(
          backRank[i], "${String.fromCharCode(97 + i)}8"); // Fila negra
      gameBoard.placePiece(
          pawns, "${String.fromCharCode(97 + i)}7"); // Peones negros
      gameBoard.placePiece(pawns.toLowerCase(),
          "${String.fromCharCode(97 + i)}2"); // Peones blancos
      gameBoard.placePiece(backRank[i].toLowerCase(),
          "${String.fromCharCode(97 + i)}1"); // Fila blanca
    }
  }

  void handleSquareTap(String location) {
    setState(() {
      if (selectedPiece != null && selectedLocation != null) {
        gameBoard.removePiece(selectedLocation!);
        gameBoard.placePiece(selectedPiece!, location);
        selectedPiece = null;
        selectedLocation = null;
      } else {
        selectedPiece = gameBoard.getPieceAt(location);
        selectedLocation = location;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
      ),
      itemCount: 64,
      itemBuilder: (context, index) {
        int row = index ~/ 8;
        int col = index % 8;
        String location = "${String.fromCharCode(97 + col)}${8 - row}";

        // Definir colores alternativos
        bool isLightSquare = (row + col) % 2 == 0;
        String? piece = gameBoard.getPieceAt(location);

        return GestureDetector(
          onTap: () => handleSquareTap(location),
          child: Container(
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: isLightSquare ? Colors.brown[300] : Colors.brown[700],
              border: Border.all(
                color: location == selectedLocation
                    ? Colors.red
                    : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                piece ?? "",
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
