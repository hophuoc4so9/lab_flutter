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
    List<Widget> _buildGridTileList(int count) => List.generate(count, (i) => Image.asset('images/pic$i.jpg'));

    Widget _buildGrid() => GridView.extent(
      maxCrossAxisExtent: 300,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: _buildGridTileList(4),
    );


    return Scaffold(
      body: Center(
        child: _buildGrid(),
      ),
    );
  }
}