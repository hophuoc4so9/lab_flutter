import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: LayoutApp(),
      )
    );
  }
}

class LayoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Padding(padding: const EdgeInsets.all(16.0),
      child:
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('I\'m in a Column and Centered. The below is a row',
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.green,
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.blue,
              )


          ]
        ),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              width: 300,
              height: 300,
              color: Colors.yellow,
            ),
            Text(
              'Stacked on Yellow Box',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ],
        )
      ],
      ),
    );
  }
}