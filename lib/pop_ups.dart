import 'package:flutter/material.dart';

Future<void> loginScreenErrorPopUp(
    {required BuildContext context,required String error,required bool sepByDash}) {
  late List<String> errorMessageParts;
  if (sepByDash) {
    errorMessageParts = error.split("-");
    for (int i = 0; i < errorMessageParts.length; i++) {
      String firstLetter = errorMessageParts[i].substring(0, 1).toUpperCase();
      List<String> temp = errorMessageParts[i].split("");
      temp[0] = firstLetter;
      errorMessageParts[i] = temp.join();
    }
  } else {
    errorMessageParts = error.split(" ");
  }
  String errorMessage = errorMessageParts.join(" ");

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Error Occurred"),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          )
        ],
      );
    },
  );
}
