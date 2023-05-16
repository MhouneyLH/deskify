import 'package:flutter/material.dart';

// a dialog that only accepts a single value
// when clicking out of the dialog, the dialog will be cancelled
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
    return WillPopScope(
      onWillPop: () async {
        widget.onCancel();
        return true;
      },
      child: AlertDialog(
        title: Text(widget.title),
        content: _buildTextField(),
        actions: [
          _buildCancelButton(),
          _buildSaveButton(),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.isNumericInput
          ? const TextInputType.numberWithOptions(
              decimal: true,
              signed: false,
            )
          : null,
    );
  }

  Widget _buildCancelButton() {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        widget.onCancel();
      },
      child: const Text('Cancel'),
    );
  }

  Widget _buildSaveButton() {
    return TextButton(
      onPressed: () {
        widget.onSave();
        Navigator.of(context).pop();
      },
      child: const Text('Save'),
    );
  }
}
