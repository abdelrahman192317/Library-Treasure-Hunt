import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Helper{
  static toast(BuildContext context ,String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Theme.of(context).shadowColor,
        //textColor: isRed? Colors.red : Theme.of(context).primaryColor,
        fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize
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