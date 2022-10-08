import 'package:flutter/material.dart';

Widget customCircularIndicator() {
  return const SizedBox(
    height: 40,
    child: CircularProgressIndicator(
      color: Colors.white,
      backgroundColor: Colors.transparent,
      strokeWidth: 5,
    ),
  );
}
