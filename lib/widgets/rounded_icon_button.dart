import 'package:betting_app/helpers/constant.dart';
import 'package:flutter/material.dart';

class RoundedIconButton extends StatelessWidget {
  final Function onPressed;
  final IconData iconData;
  final double iconSize;
  final double paddingReduce;
  final Color? buttonColor;

  const RoundedIconButton(
      {super.key,
      required this.onPressed,
      required this.iconData,
      this.iconSize = 30,
      this.buttonColor,
      this.paddingReduce = 0.0});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: 0,
      elevation: 5,
      color: buttonColor,
      onPressed: onPressed as void Function()?,
      padding: EdgeInsets.all((iconSize / 2) - paddingReduce),
      shape: const CircleBorder(),
      child: Icon(
        iconData,
        size: iconSize,
        color: yellow,
      ),
    );
  }
}
