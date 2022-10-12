import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../helpers/constant.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.icon,
      required this.hint,
      required this.label,
      required this.controller,
      this.textInputAction,
      this.suffixIcon})
      : super(key: key);
  final String hint;
  final String label;
  final IconData icon;
  final IconData? suffixIcon;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0.5),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
          cursorColor: black,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            prefixIcon: Icon(
              icon,
              color: Colors.blue,
            ),
            suffixIcon: Icon(
              suffixIcon,
              color: Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: yellow),
              borderRadius: BorderRadius.circular(13.0),
            ),
            // labelText: label,
            hintText: hint,
            labelStyle: TextStyle(color: yellow),
            hintStyle: TextStyle(color: black),
          ),
          style: TextStyle(color: black),
          controller: controller,
          textInputAction: textInputAction ?? TextInputAction.done,
          autovalidateMode: label == 'Email' ||
                  label == 'Password' ||
                  label == 'Name' ||
                  label == 'User Name'
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          validator: label == 'Email'
              ? (email) => email != null && !EmailValidator.validate(email)
                  ? 'Enter a valid Email'
                  : null
              : label == 'Password'
                  ? (password) => password != null && password.length < 6
                      ? 'Enter min 6 characters'
                      : null
                  : null),
    );
  }
}
