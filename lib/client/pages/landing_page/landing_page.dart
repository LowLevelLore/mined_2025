import 'package:flutter/material.dart';
import 'package:mined_2025/client/utils/theme/theme.dart';

class LandingPage extends StatelessWidget {
  static const route = "/";
  static const fullRoute = "/";
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: AppColors.theme['backgroundColor'],
      child: const Center(
        child: Text(
          "Landing Page",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
