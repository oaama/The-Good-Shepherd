import 'package:flutter/material.dart';

class PanicConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  const PanicConfirmationDialog({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Panic'),
      content: const Text('Are you sure you want to send a panic alert?'),
      actions: [
        TextButton(onPressed: onCancel, child: const Text('Cancel')),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
          child: const Text('Send Alert'),
        ),
      ],
    );
  }
}
