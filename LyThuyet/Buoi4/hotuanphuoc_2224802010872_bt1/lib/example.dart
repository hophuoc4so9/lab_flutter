import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  
  @override
  State<MyApp> createState() => _MyAppState();
}


  

class _MyAppState extends State<MyApp> {
  late ColorScheme currentColorScheme;
  late bool isLight;
  @override
  void initState() {
    super.initState();
    currentColorScheme = const ColorScheme.light();
    isLight = true;
  }

  @override
  Widget build(Object context) {
    final ColorScheme colorScheme = currentColorScheme;
    final Color selectedColor = currentColorScheme.primary;
    final ThemeData lightTheme = ThemeData(
      colorSchemeSeed: selectedColor,
      brightness: Brightness.light,
      useMaterial3: false,
    );
    final ThemeData darkTheme = ThemeData(
      colorSchemeSeed: selectedColor,
      brightness: Brightness.dark,
      useMaterial3: false,
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isLight ? ThemeMode.light : ThemeMode.dark,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo Home Page'),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          actions: <Widget>[
            const Icon(Icons.light_mode),
            Switch(
              value: isLight,
              onChanged: (value) {
                setState(() {
                  isLight = value;
                });
              },
            ),
          ],
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isLight = !isLight;
              });
            },
            child: const Text('Toggle Theme'),
          ),
        ),
      ),
    );
  }
  

}