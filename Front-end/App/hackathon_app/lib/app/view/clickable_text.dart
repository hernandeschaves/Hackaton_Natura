import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  ClickableText(this.text, {this.textStyle});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text,
        style: textStyle != null ? textStyle : TextStyle(color: Colors.black),
      ),
      onPressed: () {
        print(text);
      },
    );
  }
}
