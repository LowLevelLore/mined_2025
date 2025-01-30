import 'package:flutter/material.dart';
import 'package:mined_2025/client/utils/theme/theme.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap ;
  const CustomButton({super.key, required this.text, required this.onTap});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Material(
          elevation: 1,
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.theme['deepPurpleColor'],
            ),
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
