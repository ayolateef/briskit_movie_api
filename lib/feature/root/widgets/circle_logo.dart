import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircleWidget extends StatelessWidget {
  String? text;
  CircleWidget({
    Key? key, this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black12,
      radius: 80.r,
      child: Text(
        text!,
        style: TextStyle(
            fontSize: 20.0.sp,
            color: Colors.black45,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}