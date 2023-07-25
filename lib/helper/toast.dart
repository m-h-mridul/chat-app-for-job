import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showtoast({String? message}) {
  Fluttertoast.showToast(
    msg: message!,
    backgroundColor: Colors.grey,
  );
}
