import 'package:flutter/material.dart';

class URLInput extends StatelessWidget {

  final TextEditingController controller;

  const URLInput({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return TextField(

      controller: controller,

      decoration: const InputDecoration(
        labelText: 'Input URL',
        border: OutlineInputBorder(),
      ),
    );
  }
}