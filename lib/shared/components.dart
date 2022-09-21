import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import 'constant.dart';

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);

void navigateAndRemove({context, widget}) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (context) => widget),
      (route) => false,
);

void myToast({required var state, required toastState toastState}) =>
    Fluttertoast.showToast(
        msg: '${state}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: toastColor(toastState),
        textColor: Colors.white,
        fontSize: 16.0);

enum toastState { Success, Warning, Error }

Color toastColor(toastState state) {
  Color? color;
  if (state == toastState.Success) {
    color = Colors.green;
  } else if (state == toastState.Warning) {
    color = Colors.amber;
  } else {
    color = Colors.red;
  }
  return color;
}

Widget circleLoading()=>Center(child: CircularProgressIndicator(color: mainColor,),);

Widget lineLoading()=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: LinearProgressIndicator(
    color: mainColor, backgroundColor: Colors.white,
  ),
);