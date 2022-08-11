import 'package:flutter/material.dart';

OutlineInputBorder _myInputBorder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.black,
        width: 5,
      ));
}

OutlineInputBorder get inputBorder => _myInputBorder();

OutlineInputBorder _myFocusBorder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Color(0xFF08d108),
        width: 5,
      ));
}

OutlineInputBorder get focusBorder => _myFocusBorder();

OutlineInputBorder _myErrorBorder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 5,
      ));
}

OutlineInputBorder get errorBorder => _myErrorBorder();
