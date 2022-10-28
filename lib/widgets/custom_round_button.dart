import 'package:flutter/material.dart';
import '../helpers/constant.dart';

class CRoundButton extends StatelessWidget {
  const CRoundButton(
      {Key? key,
      required this.function,
      required this.text,
      this.active,
      this.textColor,
      this.height,
      this.width,
      this.fontSize,
      this.color})
      : super(key: key);
  final Function function;
  final String text;
  final bool? active;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        alignment: Alignment.center,
        width: width ?? 150,
        height: height ?? 45,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: active ?? true ? color ?? blue : Colors.grey,
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          text,
          style: TextStyle(
              color: textColor ?? white,
              fontSize: fontSize ?? 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
