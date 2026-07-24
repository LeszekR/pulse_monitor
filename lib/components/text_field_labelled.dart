import 'package:flutter/material.dart';

class TextFieldLabelled extends StatefulWidget {
  const TextFieldLabelled({super.key});

  @override
  TextFieldLabelledState createState() => TextFieldLabelledState();
}

class TextFieldLabelledState extends State<TextFieldLabelled> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text('not implemented'), TextField()]);
  }
}
