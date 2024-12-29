import 'package:flutter/material.dart';

class NoteText extends StatelessWidget {
  const NoteText({
    Key? key,
    required this.text,
    this.textAlign,
    this.color,
  }) : super(key: key);

  final String text;
  final TextAlign? textAlign;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: color ?? Colors.grey[600],
      ),
    );
  }
}
