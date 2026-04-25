import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
 

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
       
        child: Column(

          mainAxisAlignment: .center,
          children: [
            FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image:"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVr60Hil06iC47vpvSEcYpbAdd0JyI5fRvuw&s",
            )
        ],
        ),
      ),
      
    );
  }
}
