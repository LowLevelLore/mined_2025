import 'package:flutter/material.dart';

class NavbarButton extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color hoverTextColor;
  final Color lineColor;
  final VoidCallback onTap;

  const NavbarButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.hoverTextColor,
    required this.lineColor,
    required this.onTap,
  });

  @override
  State<NavbarButton> createState() => _NavbarButtonState();
}

class _NavbarButtonState extends State<NavbarButton> {
  bool _isHovered = false;
  double _lineWidth = 0.0;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() {
        _isHovered = true;
        _lineWidth = 40.0;
      }),
      onExit: (_) => setState(() {
        _isHovered = false;
        _lineWidth = 0.0;
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                color: _isHovered ? widget.hoverTextColor : widget.textColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 2,
              width: _lineWidth,
              decoration: BoxDecoration(
                color: widget.lineColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
