import 'dart:async';

// import 'dart:nativewrappers/_internal/vm/lib/async_patch.dart';
import 'package:flutter/material.dart';
import 'package:third_flutter_app/button.dart';
import 'package:third_flutter_app/pixels.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberOfSquares = 130;
  int playerPosition = 0;
  int bombPosition = -1;
  List<int> barriers = [
    11,
    31,
    51,
    71,
    91,
    111,
    13,
    33,
    53,
    73,
    93,
    113,
    15,
    35,
    55,
    75,
    95,
    115,
    117,
    97,
    77,
    57,
    37,
    17,
    18,
    38,
    58,
    78,
    98,
    118,
  ];
  List<int> boxes = [
    23,
    25,
    46,
    44,
    46,
    68,
    84,
    105,
    124,
    125,
    89,
    90,
    62,
    12,
    14,
    1628,
    21,
    41,
    61,
    81,
    101,
    112,
    114,
    119,
    116,
    127,
    123,
    103,
    83,
    63,
    65,
    67,
    47,
    39,
    19,
    28,
    1,
    30,
    50,
    73,
    121,
    100,
    96,
    79,
    99,
    107,
    7,
    3,
  ];
  List<int> fire = [-1];
  void moveUp() {
    setState(() {
      if (playerPosition > 9 &&
          !barriers.contains(playerPosition - 10) &&
          !boxes.contains(playerPosition - 10)) {
        playerPosition -= 10;
      }
    });
  }

  void moveDown() {
    setState(() {
      if (playerPosition < 120 &&
          !barriers.contains(playerPosition + 10) &&
          !boxes.contains(playerPosition + 10)) {
        playerPosition += 10;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (playerPosition % playerPosition == 0 &&
          !barriers.contains(playerPosition - 1) &&
          !boxes.contains(playerPosition - 1)) {
        playerPosition -= 1;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerPosition % playerPosition == 9 || playerPosition == 129) &&
          !barriers.contains(playerPosition + 1) &&
          !boxes.contains(playerPosition + 1)) {
        playerPosition += 1;
      }
    });
  }

  void placeBomb() {
    setState(() {
      bombPosition = playerPosition;
      fire.clear();
      Timer(Duration(milliseconds: 800), () {
        setState(() {
          fire.add(bombPosition);
          fire.add(bombPosition - 1);
          fire.add(bombPosition + 1);
          fire.add(bombPosition + 10);
          fire.add(bombPosition - 10);
        });
        clearFire();
      });
    });
  }

  void clearFire() {
    setState(() {
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          for (int i = 0; i < fire.length; i++) {
            if (boxes.contains(fire[i])) {
              boxes.remove(fire[i]);
            }
          }
          fire.clear();
          bombPosition = -1;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: numberOfSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (fire.contains(index)) {
                    return pixels(
                      innerColor: Colors.red,
                      outerColor: Colors.red[800],
                      // child: Text(index.toString()),
                    );
                  } else if (bombPosition == index) {
                    return pixels(
                      innerColor: Colors.green,
                      outerColor: Colors.green[800],
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset('lib/image/bomb.png'),
                      ),
                    );
                  } else if (playerPosition == index) {
                    return pixels(
                      innerColor: Colors.green,
                      outerColor: Colors.green[800],
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(
                          'lib/image/bomberman.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                    // child: Text(index.toString()),
                  } else if (barriers.contains(index)) {
                    return pixels(
                      innerColor: Colors.black,
                      outerColor: Colors.black,
                    );
                  } else if (boxes.contains(index)) {
                    return pixels(
                      innerColor: Colors.brown,
                      outerColor: Colors.brown[800],
                    );
                  } else {
                    return pixels(
                      innerColor: Colors.green,
                      outerColor: Colors.green[800],
                      // child: Text(index.toString()),
                    );
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(),
                      MyButton(
                        color: Colors.purple[100],
                        function: moveUp,
                        child: Icon(Icons.arrow_drop_up, size: 70),
                      ),
                      MyButton(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        color: Colors.purple[100],
                        function: moveLeft,
                        child: Icon(Icons.arrow_left, size: 70),
                      ),
                      MyButton(
                        function: placeBomb,
                        color: Colors.purple[100],
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Image.asset(
                            'lib/image/bomb.png',
                            width: 1000,
                            height: 1000,
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      MyButton(
                        color: Colors.purple[100],
                        function: moveRight,
                        child: Icon(Icons.arrow_right, size: 70),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(),
                      MyButton(
                        color: Colors.purple[100],
                        function: moveDown,
                        child: Icon(Icons.arrow_drop_down, size: 70),
                      ),
                      MyButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
