import 'package:flutter/material.dart';

class AppBigText extends StatelessWidget {
  final String text;
  final TextOverflow? textOverflow;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final String? fontFamily;
  final TextStyle? style;

  const AppBigText({
    super.key,
    required this.text,
    this.textOverflow,
    this.fontWeight,
    this.fontSize = 20,
    this.color,
    this.fontFamily,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        fontFamily: fontFamily,
      ),
    );
  }
}
