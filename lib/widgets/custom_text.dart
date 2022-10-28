import 'package:flutter/material.dart';

import '../helpers/constant.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    this.text,
    this.color,
    this.size,
    this.weight,
    Key? key,
  }) : super(key: key);
  final String? text;
  final Color? color;
  final FontWeight? weight;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'add text',
      style: TextStyle(
          fontSize: size ?? 17,
          fontWeight: weight ?? FontWeight.normal,
          color: color ?? white),
    );
  }
}
