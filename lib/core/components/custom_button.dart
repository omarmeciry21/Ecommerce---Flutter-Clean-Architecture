import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.width,
  });
  final void Function()? onPressed;
  final String label;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(24),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.black,
              fixedSize:
                  Size(width ?? MediaQuery.sizeOf(context).width - 48, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4))),
          onPressed: onPressed,
          child: Text(label,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
        ));
  }
}
