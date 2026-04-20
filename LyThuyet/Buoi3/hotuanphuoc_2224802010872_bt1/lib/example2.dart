import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Demo"),
        ),
        body: _buildImageColumn(),
      ),
    
      );
  }
}

Widget _buildImageColumn() {
  return Container(
    decoration: const BoxDecoration(color: Colors.black26),
    child: Column(children: [_buildImageRow(1), _buildImageRow(3)]),
  );
}
Widget _buildDecoratedImage(int imageIndex) => Expanded(
  child: Container(
    height: 200,
    decoration: BoxDecoration(
      border: Border.all(width: 10, color: Colors.black38),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    ),
    margin: const EdgeInsets.all(4),
    child:  Image.asset('images/pic$imageIndex.jpg',fit: BoxFit.cover,),
  ),
);

Widget _buildImageRow(int imageIndex) => Row(
  children: [
    _buildDecoratedImage(imageIndex),
    _buildDecoratedImage(imageIndex + 1),
  ],
);
