// ignore_for_file: file_names

import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  const InputButton({Key? key, this.hinttext, this.onchange, this.controller, this.chose}) : super(key: key);

  final String? hinttext;
  final Function()? onchange;
  final bool? chose;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      obscureText: chose ?? false,
      onChanged: (e) => onchange,
      controller: controller,
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
      ),
    );
  }
}
