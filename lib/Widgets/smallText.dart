import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SmallText extends StatelessWidget {
  final Color color;
  final String text;
  final double height;
  final int size;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final TextOverflow overflow;
  const SmallText(
      {Key? key,
      this.color = Colors.black,
      required this.text,
      this.size = 12,
      this.fontWeight = FontWeight.normal,
      this.textAlign = TextAlign.center,
      this.height = 1,
      this.overflow = TextOverflow.visible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: 'Poppins',
          color: color,
          fontSize: size.sp,
          fontWeight: fontWeight,
          height: height),
    );
  }
}
