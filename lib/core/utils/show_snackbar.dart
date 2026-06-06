import 'package:flutter/material.dart'
    show BuildContext, ScaffoldMessenger, SnackBar;
import 'package:flutter/widgets.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(content)));
}
