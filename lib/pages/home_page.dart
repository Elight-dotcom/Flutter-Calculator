import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // input & output
  String _input = '';
  String _output = '';

  // button pressed
  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _input = '';
        _output = '';
      } else if (value == '=') {
        _output = _result(_input);
      } else if (value == '+' || value == '-' || value == 'x' || value == '÷') {
        _input += ' $value ';
      } else {
        _input += value;
      }
    });
  }

  // result
  String _result(String input) {
    input = input.replaceAll('x', '*').replaceAll('÷', '/');
    List<String> inputList = input.split(' ');

    double result = double.parse(inputList[0]);
    for (int i = 1; i < inputList.length; i += 2) {
      String operator = inputList[i];
      double next = double.parse(inputList[i + 1]);

      switch (operator) {
        case '+':
          result += next;
          break;
        case '-':
          result -= next;
          break;
        case '*':
          result *= next;
          break;
        case '/':
          result /= next;
          break;
      }
    }
    return result.toString();
  }

  // button list
  List buttons = [
    ['7', '8', '9', '÷'],
    ['4', '5', '6', 'x'],
    ['1', '2', '3', '-'],
    ['C', '0', '=', '+'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kalkulator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              padding: EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // input
                  Text(
                    _input,
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),

                  // output
                  Text(
                    _output,
                    style: TextStyle(fontSize: 64, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          // buttons
          Container(
            padding: EdgeInsets.all(12),
            child: Table(
              children: [
                for (var i = 0; i < buttons.length; i++)
                  TableRow(
                    children: [
                      for (var j = 0; j < buttons[i].length; j++)
                        Container(
                          padding: EdgeInsets.all(12),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () => _buttonPressed(buttons[i][j]),
                              child: Text(
                                buttons[i][j],
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
