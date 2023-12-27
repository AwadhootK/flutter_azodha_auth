
import 'package:flutter/material.dart';

SnackBar customSnackBar({required String content}) {
  return SnackBar(
    backgroundColor: Colors.grey,
    content: Text(content,
        style: const TextStyle(
          color: Colors.white,
        ) //letterSpacing: 0.5),
        ),
  );
}