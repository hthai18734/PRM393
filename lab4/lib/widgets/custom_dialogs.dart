import 'package:flutter/material.dart';

class CustomDialogs {
  // Shows validation alert dialog matching Figure 2
  static Future<void> showValidationDialog(
    BuildContext context,
    String message,
  ) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: const Text(
            'Validation',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text(
                'OK',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  // Shows success alert dialog matching Figure 2
  static Future<void> showSuccessDialog(
    BuildContext context,
    String message, {
    VoidCallback? onOk,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: const Text(
            'Success',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                if (onOk != null) {
                  onOk();
                }
              },
              child: const Text(
                'OK',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  // Shows confirm delete dialog matching Figure 2
  static Future<bool> showConfirmDeleteDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: const Text(
            'Confirm Delete',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: const Text(
            'Are you sure you want to delete this bill?',
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text(
                'CANCEL',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text(
                'DELETE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }
}
