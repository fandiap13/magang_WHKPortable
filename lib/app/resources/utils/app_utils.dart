import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wish/app/resources/colors/app_colors.dart';

class AppUtils {
  static void alertDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  static void confirmDialog(BuildContext context, String title, String content,
      String actionButtonText, VoidCallback action, bool closeDialog) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              onPressed: () {
                action();

                if (closeDialog) {
                  Navigator.of(context).pop();
                }
              },
              child: Text(actionButtonText),
            ),
          ],
        );
      },
    );
  }

  static void scaffoldMessenger(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static void toast(String message, Color? color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: color ?? AppColors.primaryColor,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 5,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static dynamic convertJsonFormat(String message) {
    // Remove the outer curly braces if they exist
    if (message.startsWith('{') && message.endsWith('}')) {
      message = message.substring(1, message.length - 1);
    }

    // Split the message into key-value pairs
    List<String> keyValuePairs = message.split(',');

    // Create a Map to store key-value pairs
    Map<String, dynamic> jsonData = {};

    for (String pair in keyValuePairs) {
      List<String> parts = pair.split(':');
      if (parts.length == 2) {
        String key =
            parts[0].trim(); // Trim the key to remove leading/trailing spaces
        String value =
            parts[1].trim(); // Trim the value to remove leading/trailing spaces
        jsonData[key] = _parseValue(value);
      }
    }

    return jsonData;
  }

  static dynamic _parseValue(String value) {
    if (value == "null") {
      return null;
    } else if (value == "true") {
      return true;
    } else if (value == "false") {
      return false;
    } else if (value.startsWith("0")) {
      // If the value starts with "0", keep it as a string to preserve leading zeros
      return value;
    } else {
      // Try parsing as an integer, and if it fails, return the value as is
      int? intValue = int.tryParse(value);
      if (intValue != null) {
        return intValue;
      } else {
        return value;
      }
    }
  }
}
