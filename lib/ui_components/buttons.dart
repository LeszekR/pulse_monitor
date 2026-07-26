import 'package:flutter/material.dart';

class Buttons {
  static ElevatedButton rectangleButton({
    required BuildContext context,
    required String text,
    required Function() onPressed,
    double borderRadius = 4,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(BeveledRectangleBorder(borderRadius: BorderRadius.circular(borderRadius))),
      ),
      child: Text(text),
    );
  }
}
