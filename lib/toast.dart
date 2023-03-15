// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";

toast(msgt) {
  Fluttertoast.showToast(
      msg: msgt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color.fromARGB(255, 86, 75, 247),
      textColor: Colors.white,
      fontSize: 16.0);
}
