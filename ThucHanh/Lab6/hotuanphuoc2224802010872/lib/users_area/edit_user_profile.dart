import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotuanphuoc2224802010872/constants/api_endpoints.dart';
import 'package:hotuanphuoc2224802010872/constants/app_colors.dart';
import 'package:hotuanphuoc2224802010872/constants/token_handler.dart';
import 'package:hotuanphuoc2224802010872/models/user_model.dart';
import 'package:hotuanphuoc2224802010872/services/fetch_email.dart';
import 'package:hotuanphuoc2224802010872/services/role_check.dart';
import 'package:hotuanphuoc2224802010872/shared/custome_appbar.dart';
import 'package:hotuanphuoc2224802010872/shared/error_dialog.dart';
import 'package:hotuanphuoc2224802010872/shared/submit_button.dart';
import 'package:hotuanphuoc2224802010872/shared/text_fields.dart';

import 'package:http/http.dart' as http;


class EditUserProfile extends StatefulWidget {
  final String email;
  const EditUserProfile({super.key, required this.email});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
  }

  @override
  void initState() {
    super.initState();
    RoleCheck().checkUserRole(context);
    getAdminInfo(widget.email);
    _emailController.text = widget.email;
  }

  Future<void> getAdminInfo(String email) async {
    var result = await http.post(
      Uri.parse(ApiEndpoints.userInfoReadUpdate),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${TokenHandler().getToken()}',
      },
      body: json.encode(email),
    );
    if (result.statusCode >= 200 && result.statusCode <= 299) {
      final jsonData = json.decode(result.body);
      final user = UserModel.fromJson(jsonData);

      setState(() {
        _emailController.text = user.email;
        _phoneNumberController.text = user.phoneNumber ?? '';
      });
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

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      var result = await http.put(
        Uri.parse(ApiEndpoints.userInfoReadUpdate),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${TokenHandler().getToken()}',
        },
        body: jsonEncode({
          "email": _emailController.text,
          "phoneNumber": _phoneNumberController.text,
        }),
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
        title: "Edit Profile",
        color: AppColors.userPage,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "User Details",
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
                  emailTextField(
                      emailController: _emailController, readOnly: true),
                  const SizedBox(height: 20),
                  phoneNumberField(
                      phoneNumberController: _phoneNumberController),
                  const SizedBox(height: 20),
                  submitButton(
                    context: context,
                    backgroundColor: AppColors.userPage,
                    textColor: Colors.white,
                    title: "Update",
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