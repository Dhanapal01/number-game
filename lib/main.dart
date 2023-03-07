// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

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
  int numberoftimes = 10;
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
      body: Builder(
        builder: (context) {
          return Center(
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
                  onPressed: (guess),
                  child: Text(
                    "guess",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ]),
          );
        },
      ),
    );
  }

  void guess() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (isempty()) {
      final text = "this is empty ";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(text),
          padding: EdgeInsets.all(30),
          backgroundColor: Colors.green));
      return;
    }

    int guess = int.parse(guessnumber.text);

    numberoftries++;
    if (numberoftries == numberoftimes && guess != randomnumber) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "game over! your number of tries is : $numberoftries my number is :$randomnumber"),
        padding: EdgeInsets.all(30),
      ));
      numberoftries = 0;
      randomnumber = ran.nextInt(100) + 1;
      guessnumber.clear();
      return;
    }
    if (guess > randomnumber) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("your number is higher $numberoftries"),
        padding: EdgeInsets.all(30),
      ));
    } else if (guess < randomnumber) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("your number lower : $numberoftries"),
          padding: EdgeInsets.all(30)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text("That's right.you win! number of tries is : $numberoftries"),
          padding: EdgeInsets.all(30)));
      numberoftries = 0;
      randomnumber = ran.nextInt(100) + 1;
    }
    guessnumber.clear();
  }

  bool isempty() {
    return guessnumber.text.isEmpty;
  }
}
