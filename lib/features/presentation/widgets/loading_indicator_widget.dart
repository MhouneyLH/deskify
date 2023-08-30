import 'package:flutter/material.dart';

/// A widget that displays a loading indicator.
/// It is used e. g. when the app is loading data from the backend.
///
/// The loading indicator is displayed as a [CircularProgressIndicator] internally.
class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
