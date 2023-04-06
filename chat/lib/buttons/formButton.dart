// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  const FormButton({Key? key, this.colour, this.onPress,this.cardChild}) : super(key: key);

  final Color? colour;
  final Function()? onPress;
  final Widget? cardChild;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 200.0,
          height: 42.0,
          child: cardChild,
        ),
      ),
    );
  }
}
