import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'guess number',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'GUESS NUMBER'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int numberoftries = 0;
  int numberoftimes = 5;
  final guessnumber = TextEditingController();
  static Random ran = Random();
  int randomnumber = ran.nextInt(100) + 1;
  @override
  Widget build(BuildContext context) {
    var uiborder = const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.pink),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(children: <Widget>[
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'I\'m thinking of number bt 1 to 100.you only have 5 tries.',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.grey),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'can you guess it',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    enabledBorder: uiborder,
                    focusedBorder: uiborder,
                    hintText: 'please enter a number'),
                keyboardType: TextInputType.number,
                controller: guessnumber),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: guess,
              // ignore: prefer_const_constructors
              child: Text(
                "guess",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void guess() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (isempty()) {
      makeToast("this is empty");
      return;
    }
    int guess = int.parse(guessnumber.text);
    if (guess > 20 || guess > 1) {
      makeToast("choose number bt 1 and 100 ");
      guessnumber.clear();
      return;
    }
    numberoftries++;
    if (numberoftries == numberoftimes && guess != randomnumber) {
      makeToast(
          "game over! your number of tries is : $numberoftries my number is :$randomnumber");
      numberoftries = 0;
      randomnumber = ran.nextInt(100) + 1;
      guessnumber.clear();
      return;
    }
    if (guess > randomnumber) {
      makeToast("your number is lower : $numberoftries");
    } else if (guess < randomnumber) {
      makeToast("your number is hiegher : $numberoftries");
    } else {
      makeToast("That's right.you win! number of tries is : $numberoftries");
      numberoftries = 0;
      randomnumber = ran.nextInt(100) + 1;
    }
    guessnumber.clear();
  }

  bool isempty() {
    return guessnumber.text.isEmpty;
  }

  void makeToast(String feedback) {
    Fluttertoast.showToast(
        msg: feedback,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14);
  }
}
