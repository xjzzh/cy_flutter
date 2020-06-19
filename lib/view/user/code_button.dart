import 'package:flutter/material.dart';

class CodeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final int coldDownSeconds;

  CodeButton({@required this.onPressed, @required this.coldDownSeconds});

  @override
  Widget build(BuildContext context) {
    if (coldDownSeconds > 0) {
      return Container(
        width: 95,
        color: Colors.grey.withOpacity(.4),
        child: Center(
          child: Text(
            '${coldDownSeconds}s',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[100]
            ),
          ),
        ),
      );
    }
    /* if (phoneNumber.isEmpty || phoneNumber.length > 11) {
      return Container(
        width: 95,
        color: Colors.grey.withOpacity(.4),
        child: Text(
          '获取验证码',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.grey[100]
          )
        ),
      );
    } */

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 95,
        height: 36,
        margin: EdgeInsets.only(top:10),
        decoration: BoxDecoration(
          border: Border.all(width:1,color: Colors.yellowAccent)
        ),
        child: Text(
          '获取验证码',
          style: TextStyle(fontSize: 14,color: Colors.white)
        ),
      ),
    );
  }
}