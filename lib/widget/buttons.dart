import 'package:flutter/material.dart';

class ButtonsArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () {},
          child: const Text('Today'),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Tomorrow'),
        ),
      ]
    );
  }
}