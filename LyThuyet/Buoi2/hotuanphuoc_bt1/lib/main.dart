import 'package:flutter/material.dart';

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
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        bottomNavigationBar: NavigationBar(onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.notification_add_sharp), label: 'Notifications'),
          NavigationDestination(icon: Icon(Icons.chat), label: 'Chat'),
        ],
        ),

      body: SizedBox(
        height: 250,
        child: Card(
          margin: EdgeInsets.all(16.0),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Hello, Flutter!'),
                subtitle: Text("welcome to the world of Flutter"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Yes'),
                    SizedBox(width: 8),
                  Text('No, thanks'),
                ],
              )
            ],
          ),
        ),
      ),
      );
  }
}
