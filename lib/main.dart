import 'package:flutter/material.dart';

void main () => runApp(TicTacToe());

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: TicTacToePage(title: 'Tic Tac Toe'),
    );
  }
}
class TicTacToePage extends StatefulWidget {
  TicTacToePage({super.key, required this.title});
  final String title;
  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}
class GameButton {
  final id;
  String text;
  bool enabled;
  GameButton({this.id, this.text = "", this.enabled = false});
}
class _TicTacToePageState extends State<TicTacToePage> {
  bool ohTurn = true;
  List<String> displayExOh = [
    '','','','','','','','','',
  ];
  var myTextStyle = const TextStyle(color: Colors.black, fontSize: 60 );
  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('玩家 O', style: myTextStyle,),
                        Text(filledBoxes.toString(), style: myTextStyle,),
                      ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('玩家 X', style: myTextStyle,),
                        Text('0', style: myTextStyle,),
                      ],),
                  )
                ],),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Text(
                          displayExOh[index],
                          style: const TextStyle(
                              color: Colors.black, fontSize: 200),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'O';
        filledBoxes += 1;
      } else if (!ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'X';
        filledBoxes += 1;
      }
      ohTurn = !ohTurn;
      _checkWinner();
    });
  }
  void _checkWinner() {
    if (displayExOh[0] == displayExOh[1] && displayExOh[0] == displayExOh[2] && displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }
    if (displayExOh[3] == displayExOh[4] && displayExOh[3] == displayExOh[5] && displayExOh[3] != '') {
      _showWinDialog(displayExOh[3]);
    }
    if (displayExOh[6] == displayExOh[7] && displayExOh[6] == displayExOh[8] && displayExOh[6] != '') {
      _showWinDialog(displayExOh[6]);
    }
    if (displayExOh[0] == displayExOh[3] && displayExOh[0] == displayExOh[6] && displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }
    if (displayExOh[1] == displayExOh[4] && displayExOh[1] == displayExOh[7] &&  displayExOh[1] != '') {
      _showWinDialog(displayExOh[1]);
    }
    if (displayExOh[2] == displayExOh[5] && displayExOh[2] == displayExOh[8] && displayExOh[2] != '') {
      _showWinDialog(displayExOh[2]);
    }
    if (displayExOh[6] == displayExOh[4] && displayExOh[6] == displayExOh[2] && displayExOh[6] != '') {
      _showWinDialog(displayExOh[6]);
    }
    if (displayExOh[0] == displayExOh[4] && displayExOh[0] == displayExOh[8] && displayExOh[0] != '') {
      _showWinDialog(displayExOh[0]);
    }
    else if(filledBoxes == 9){
      _showDrawDialog();
    }
  }
  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('和局'),
            actions: [
              TextButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: const Text('再玩一次'),
              ),],
          );
        });
  }
  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('贏家是: $winner'),
            actions: [
              TextButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: const Text('再玩一次'),
              ),],
          );
        });
    if(winner == 'O') {
      ohScore += 1;
    } else if (winner == 'X') {
      exScore += 1;
    }
  }
  void _clearBoard() {
    setState(() {
      for(int i=0; i<9; i++){
        displayExOh[i] = '';
      }
    });
    filledBoxes = 0;
  }
}

