// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ButtomButton extends StatelessWidget {
  const ButtomButton({Key? key, this.card, this.onpress, this.color, this.controller}) : super(key: key);

  final Widget? card;
  final Function()? onpress;
  final Color? color;

  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onpress,
          minWidth: 200.0,
          height: 42.0,
          child: card,
        ),
      ),
    );
  }
}
