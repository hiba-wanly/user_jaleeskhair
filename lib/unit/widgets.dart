import 'package:another_flushbar/flushbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future FlushBar (String message, double h ,BuildContext context) =>
    Flushbar(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.white,
      messageColor: Colors.black,
      messageSize: h * 0.02,
      message: message,
    ).show(context);

