import 'package:flutter/material.dart';
import 'package:hotuanphuoc_2224802010872_lab3_1/api/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 3 - form - login - dio - hotuanphuoc_2224802010872',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const ResetPasswordScreen(),
    );
  }
}

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The filed cannot be empty';
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Invalid email address';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await api.send("sign-up", {"email": emailController.text});

                    showDialog(
                      context: context,
                      builder: (_) => const AlertDialog(
                        title: Text('Successfully'),
                        content: Text('Đã reset password'),
                      ),
                    );
                  }
                },
                child: const Text('Reset Password'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
