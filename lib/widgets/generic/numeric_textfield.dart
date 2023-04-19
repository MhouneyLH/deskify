import 'package:flutter/material.dart';

class NumericTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final void Function(String value) onSubmitted;

  const NumericTextfield({
    required this.controller,
    required this.title,
    required this.onSubmitted,
    super.key,
  });

  @override
  State<NumericTextfield> createState() => _NumericTextfieldState();
}

class _NumericTextfieldState extends State<NumericTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      ),
      decoration: InputDecoration(labelText: widget.title),
      onSubmitted: (String value) => widget.onSubmitted(value),
    );
  }
}
