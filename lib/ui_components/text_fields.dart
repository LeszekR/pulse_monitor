import 'package:flutter/material.dart';

enum BorderType { underline, outline }

enum LabelPosition { top, bottom, left, right }

class TextFields {
  static Widget textField({
    BorderType borderType = BorderType.outline,
    String? outerLabel,
    LabelPosition? labelPosition,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
  }) {
    assert(
      (outerLabel == null) == (labelPosition == null),
      'labelPosition and outerLabel must be both null or both declared',
    );

    TextField textField = TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: borderType == BorderType.outline ? OutlineInputBorder() : UnderlineInputBorder(),
      ),
    );

    switch (labelPosition) {
      case null:
        return textField;
      case LabelPosition.top:
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(outerLabel!), textField]);
      case LabelPosition.bottom:
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [textField, Text(outerLabel!)]);
      case LabelPosition.left:
        return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [Text(outerLabel!), textField]);
      case LabelPosition.right:
        return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [textField, Text(outerLabel!)]);
    }
  }
}
