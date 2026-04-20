import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _buildStack() {
        return Stack(
          alignment: const Alignment(0.6, 0.6),
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('images/pic1.jpg'),
              radius: 100,
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.black45),
              child: const Text(
                'Mia B',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      }



    return Scaffold(
      body: Center(
        child: _buildStack(),
      ),
    );
  }
}