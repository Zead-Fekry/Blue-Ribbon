import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class SnackBarMessage {
  void showSuccessSnackBar(
      {required String message, required BuildContext context , VoidCallback? fn,}) {
    PanaraInfoDialog.show(
      context,
      title:   "Success",
      message: message,
      buttonText:   "Okay" ,
      color: Colors.green.shade900,

      onTapDismiss: fn??() {
        Navigator.pop(context);
      },
      panaraDialogType: PanaraDialogType.success,
      barrierDismissible: fn ==null, // optional parameter (default is true)
    );

  }

  void showErrorSnackBar(
      {required String message, required BuildContext context , VoidCallback? fn}) {
    PanaraInfoDialog.show(
      context,
      title:   "Error" ,
      message: message,
      buttonText:"Okay",
      color: Colors.red.shade900,
      onTapDismiss: fn ??() {
        Navigator.pop(context);
      },
      panaraDialogType: PanaraDialogType.error,
      barrierDismissible: fn == null, // optional parameter (default is true)
    );
  }
}