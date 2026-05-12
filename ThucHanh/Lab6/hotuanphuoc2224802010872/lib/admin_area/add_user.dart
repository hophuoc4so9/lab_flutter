import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotuanphuoc2224802010872/constants/api_endpoints.dart';
import 'package:hotuanphuoc2224802010872/constants/app_colors.dart';
import 'package:hotuanphuoc2224802010872/constants/token_handler.dart';
import 'package:hotuanphuoc2224802010872/models/register_model.dart';
import 'package:hotuanphuoc2224802010872/services/role_check.dart';
import 'package:hotuanphuoc2224802010872/shared/custome_appbar.dart';
import 'package:hotuanphuoc2224802010872/shared/error_dialog.dart';
import 'package:hotuanphuoc2224802010872/shared/submit_button.dart';
import 'package:hotuanphuoc2224802010872/shared/text_fields.dart';

import 'package:http/http.dart' as http;

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    RoleCheck().checkAdminRole(context);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
  }

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      final registerData = RegisterModel(
        email: _emailController.text,
        password: _passwordController.text,
        phoneNumber: _phoneNumberController.text,
      );

      var result = await http.post(
        Uri.parse(ApiEndpoints.adminUsersCrud),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${TokenHandler().getToken()}',
        },
        body: jsonEncode(registerData.toJson()),
      );

      if (result.statusCode >= 200 && result.statusCode <= 299) {
        if (!mounted) return;
        Navigator.of(context).pop();
      } else {
        var errorBody = jsonDecode(result.body);
        final error = errorBody['message'] ?? "An error occurred.";

        if (!mounted) return;

        errorDialog(
          context: context,
          statusCode: result.statusCode,
          description: error,
          color: Colors.green,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: "Add New User",
        color: AppColors.adminPage,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Enter User Details",
            style: TextStyle(
              color: Color.fromRGBO(56, 56, 56, .9),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  emailTextField(emailController: _emailController),
                  const SizedBox(height: 20),
                  passwordTextField(passwordController: _passwordController),
                  const SizedBox(height: 20),
                  phoneNumberField(
                      phoneNumberController: _phoneNumberController),
                  const SizedBox(height: 20),
                  submitButton(
                    context: context,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    title: "Add New User",
                    method: submitForm,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}