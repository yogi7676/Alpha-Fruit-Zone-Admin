import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  const CustomText(
      {Key? key,
      required this.text,
      required this.size,
      this.color,
      this.weight,
      this.overflow,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
          fontSize: size ?? 16,
          color: color ?? Colors.black,
          overflow: overflow ?? TextOverflow.ellipsis,
          fontWeight: weight ?? FontWeight.normal),
    );
  }
}