import 'package:flutter/material.dart';

class SingleValueAlertDialog extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool isNumericInput;
  final void Function() onSave;
  final void Function() onCancel;

  const SingleValueAlertDialog({
    required this.title,
    required this.controller,
    this.isNumericInput = false,
    required this.onSave,
    required this.onCancel,
    super.key,
  });

  @override
  State<SingleValueAlertDialog> createState() => _SingleValueAlertDialogState();
}

class _SingleValueAlertDialogState extends State<SingleValueAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: widget.controller,
        keyboardType: TextInputType.numberWithOptions(
          decimal: widget.isNumericInput,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            widget.onCancel();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onSave();
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
