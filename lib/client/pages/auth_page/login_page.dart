import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mined_2025/client/providers/bucket_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/theme/theme.dart';

class LoginPage extends StatefulWidget {
  static const route = "/login";
  static const fullRoute = "/login";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isRegisterHovered = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<BucketsProvider>(builder: (context,bucketProvider,child){
      return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.theme['backgroundColor'],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 100.0, top: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sign In to",
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Our Application",
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "If you don't have an account",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "You can",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) => setState(() => _isRegisterHovered = true),
                          onExit: (_) => setState(() => _isRegisterHovered = false),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.go('/register');
                                  bucketProvider.isLoginEnabled = false;
                                },
                                child: Text(
                                  "Register here!",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color:!_isRegisterHovered ? AppColors.theme['deepPurpleColor'] :Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top: 2.0),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: 2,
                                  width: (_isRegisterHovered) ? 100.0 : 0.0,
                                  decoration: BoxDecoration(
                                    color: AppColors.theme['deepPurpleColor'],
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
