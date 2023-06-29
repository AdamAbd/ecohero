import 'package:flutter/material.dart';

class FocusUtils {
  BuildContext context;

  FocusUtils(
    this.context,
  );

  void unfocus() {
    if (FocusScope.of(context).hasFocus) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
