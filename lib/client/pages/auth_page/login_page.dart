import 'package:flutter/material.dart';

import '../../utils/theme/theme.dart';

class LoginPage extends StatelessWidget {
  static const route = "/login";
  static const fullRoute = "/login";
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.theme['backgroundColor'],
      ),
      child: const Center(
        child: Text(
          "Login Page",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
