import 'dart:io';

List<String> game = List.generate(9, (number) => (number + 1).toString());
String currentPlayer = 'X';

void printGame() {
  for (int i = 0; i < 9; i += 3) {
    print('${game[i]} | ${game[i + 1]} | ${game[i + 2]}');
    if (i < 6) print('--+---+--');
  }
}

bool play(int number) {
  if (number < 1 || number > 9 || game[number - 1] != (number).toString()) {
    print('Invalid move.');
    return false;
  }

  game[number - 1] = currentPlayer;
  printGame();

  if (whoWins()) {
    print('Player $currentPlayer wins!!!!!');
    return true;
  } else if (game.every((square) => square != (game.indexOf(square) + 1).toString())) {
    print('It\'s a draw!');
    return true;
  } else {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
    return false;
  }
}

bool whoWins() {
  for (int i = 0; i < 3; i++) {
    if (game[i] != (i + 1).toString() && game[i] == game[i + 3] && game[i] == game[i + 6]) {
      return true;
    }
    if (game[i * 3] != (i * 3 + 1).toString() && game[i * 3] == game[i * 3 + 1] && game[i * 3] == game[i * 3 + 2]) {
      return true;
    }
  }

  if (game[0] != '1' && game[0] == game[4] && game[0] == game[8]) {
    return true;
  }
  if (game[2] != '3' && game[2] == game[4] && game[2] == game[6]) {
    return true;
  }

  return false;
}

void main() {
  print('THE GAME STARTED!!!!');
  printGame();
  while (true) {
    print('Player $currentPlayer, please enter the number of the square where you want to place your $currentPlayer:');
    int? move = int.tryParse(stdin.readLineSync()!);

    if (move != null && move >= 1 && move <= 9) {
      if (play(move)) {
        break;
      }
    } else {
      print('Invalid input.');
    }
  }
}
