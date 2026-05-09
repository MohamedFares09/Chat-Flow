import 'package:flutter/material.dart';

void buildSnackBar(
  BuildContext context, {
  required String message,
  required Color color,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
}
