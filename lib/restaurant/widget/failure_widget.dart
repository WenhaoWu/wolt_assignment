import 'package:flutter/widgets.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Something went wrong"));
  }
}
