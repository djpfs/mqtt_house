import 'package:flutter/material.dart';

Widget chipItem(String title, color) {
  return Chip(
    backgroundColor: color,
    padding: EdgeInsets.all(10),
    shadowColor: Colors.transparent,
    label: Text(
      title,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 14,
        letterSpacing: 3,
        color: Colors.white,
        fontWeight: FontWeight.w800,
      ),
    ),
  );
}
