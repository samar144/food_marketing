import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:food_delivery/diminsions.dart';

class BigText extends StatelessWidget {
  final String text;
  Color? color;
  TextOverflow overflow;
  double size;

  BigText(
      {Key? key,
      required this.text,
      this.color = const Color(0xFF332d2b),
      this.overflow = TextOverflow.ellipsis,
      this.size = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overflow,
      style: TextStyle(
          color: color,
          fontFamily: 'Roboto',
          fontSize: size == 0 ? Diminsions.font20 : size,
          fontWeight: FontWeight.w400),
    );
  }
}
