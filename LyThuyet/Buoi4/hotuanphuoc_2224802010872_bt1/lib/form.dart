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
  
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Demo Home Page'),
        ),
        body: Center(
  child: Builder(
    builder: (context) {
          return Column(
            children: 
            [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final String name = _controller.text ?? '';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('hello $name')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          );
        },
        ),
      ),
    )
    );
  }
}