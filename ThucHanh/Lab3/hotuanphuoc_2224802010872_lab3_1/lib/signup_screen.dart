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
      home: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usenameController = TextEditingController();
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
              const SizedBox(height: 40),
              Image.asset("images/sign-up.png", width: 100, height: 100),
              const SizedBox(height: 20),
              TextFormField(
                controller: usenameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The filed cannot be empty';
                  }

                  return null;
                },
              ),
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
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The filed cannot be empty';
                  }
                  if (value.length < 7) {
                    return 'The password must be at least 7 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final res = await api.signUp({
                        "username": usenameController.text,
                        "email": emailController.text,
                        "password": passwordController.text,
                      });

                      if (res.statusCode == 201) {
                        showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                            title: Text('Successfully'),
                            content: Text('Đăng ký thành công.'),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                            title: Text('Failed'),
                            content: Text('Đăng ký thất bại'),
                          ),
                        );
                      }
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Error'),
                          content: Text('$e'),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Sign up'),
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
