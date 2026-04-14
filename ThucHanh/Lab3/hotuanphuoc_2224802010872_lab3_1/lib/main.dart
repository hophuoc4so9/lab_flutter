import 'package:flutter/material.dart';
import 'package:hotuanphuoc_2224802010872_lab3_1/api/api_service.dart';
import 'package:hotuanphuoc_2224802010872_lab3_1/reset_password_sreen.dart';
import 'package:hotuanphuoc_2224802010872_lab3_1/signup_screen.dart';

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
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Login Screen'),
              const SizedBox(height: 40),
              Image.asset("images/login.png", width: 100, height: 100),
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
                      final res = await api.login(
                        emailController.text,
                        passwordController.text,
                      );

                      if (res.statusCode == 200) {
                        showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                            title: Text('Successfully'),
                            content: Text('Login successfully.'),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                            title: Text('Failed'),
                            content: Text('Invalid email or password.'),
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
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                },
                child: const Text('Sign Up'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetPasswordScreen(),
                    ),
                  );
                },
                child: const Text('Forgot password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
