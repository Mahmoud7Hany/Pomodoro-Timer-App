import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget(
      {super.key, required this.onPressed, required this.text});

  final Function onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(const Color.fromARGB(255, 197, 25, 97)),
        padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 23),
      ),
    );
  }
}
