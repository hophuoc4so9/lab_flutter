import 'package:flutter/material.dart';
import 'package:hotuanphuoc2224802010872/constants/boder_style.dart';
import 'package:hotuanphuoc2224802010872/models/user_model.dart';
import 'package:hotuanphuoc2224802010872/shared/text_fields.dart';

void userDetails({
  required BuildContext context,
  required UserModel user,
  required Color color,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            const Text("User Details"),
            const SizedBox(height: 10),
            userDetailsTextField(label: "Id", value: user.id),
            const SizedBox(height: 10),
            userDetailsTextField(label: "Email", value: user.email),
            const SizedBox(height: 10),
            userDetailsTextField(
                label: "Phone Number",
                value: user.phoneNumber ?? "Not Provided"),
            const SizedBox(height: 10),
            userDetailsTextField(
                label: "Role",
                value: user.role?.join(', ') ?? 'No roles available.')
          ],
        ),
        actions: [
          MaterialButton(
            color: color,
            textColor: Colors.white,
            padding: const EdgeInsets.all(18),
            hoverElevation: 0,
            elevation: 0,
            focusElevation: 0,
            shape: BorderStyles.buttonBorder,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Ok"),
          )
        ],
        actionsAlignment: MainAxisAlignment.center,
      );
    },
  );
}