import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(debugShowCheckedModeBanner: false, home: MyButton()));
}

class MyButton extends StatefulWidget {
  @override
  MyButtonState createState() {
    return MyButtonState();
  }
}

class MyButtonState extends State<MyButton> {
  TextEditingController _controller = new TextEditingController();
  String displayedString = generateSnils();

  void onPressOfButton() {
    setState(() {
      Timer(Duration(milliseconds: 200), () {
        _controller.text = mask(generateSnils());
        displayedString = generateSnils();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Генератор СНИЛС"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration.collapsed(
                    hintText: mask(generateSnils()), hintStyle: TextStyle(fontSize: 40.0, color: Colors.green)),
                controller: _controller,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40.0, color: Colors.green),
                readOnly: true,
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              ButtonTheme(
                  minWidth: 250.0,
                  height: 60.0,
                  child: RaisedButton(
                    child: Text("Сгенерировать СНИЛС", style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    color: Colors.red,
                    onPressed: onPressOfButton,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

String generateSnils() {
  final random = new Random().nextDouble() * 999999999;
  final number = random.floor().toString().padLeft(9, "0");

  List numList = number.split("");
  int sum = 0;

  var checkSum;

  for (int i = 0; i < 9; i++) {
    sum = sum + int.parse(numList[i]) * (9 - i);
  }

  if (sum > 101) {
    sum = sum % 101;
  }

  if (sum == 100 || sum == 101) {
    checkSum = "00";
  } else {
    checkSum = sum.toString().padLeft(2, "0");
  }

  return number + checkSum;
}

String mask(String number) {
  return "${number.substring(0, 3)} ${number.substring(3, 6)} ${number.substring(6, 9)} ${number.substring(9)}";
}
