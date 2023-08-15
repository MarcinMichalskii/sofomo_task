import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color backgroundColor;
  final String text;
  final VoidCallback? onPressed;

  const RoundedButton({
    super.key,
    required this.backgroundColor,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor)),
      child: Text(text),
    );
  }
}
