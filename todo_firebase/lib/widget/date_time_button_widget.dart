import 'package:flutter/material.dart';

class DateTimeButton extends StatelessWidget {
  const DateTimeButton({
    super.key,
    required this.bgColor,
    required this.textColor,
    required this.btnText,
    required this.onPressed,
  });

  final Color bgColor;
  final Color textColor;
  final String btnText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(color: Colors.blue.shade800),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () => onPressed(),
        child: Text(btnText),
      ),
    );
  }
}
