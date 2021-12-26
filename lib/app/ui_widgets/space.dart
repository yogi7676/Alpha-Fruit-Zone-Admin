import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  final double? width;
  final double? height;
  const Space({Key? key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 10,
      width: width ?? 10,
    );
  }
}