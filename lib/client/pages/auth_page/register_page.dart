import 'package:flutter/material.dart';
import 'package:mined_2025/main.dart';

import '../../utils/theme/theme.dart';

class RegisterPage extends StatefulWidget {
  static const route = "/register";
  static const fullRoute = "/register";
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.theme['bgGradient1Color']!,
            AppColors.theme['bgGradient2Color']!,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child:  Center(
        child: Text(
          "Register Page",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
