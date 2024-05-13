import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Helper{
  static toast(BuildContext context ,String message){
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }
}

extension ContextEx on BuildContext
{
  TextTheme getThemeTextStyle()
  {
    return Theme.of(this).textTheme;
  }
}