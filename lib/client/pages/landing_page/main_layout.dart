import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mined_2025/client/utils/theme/theme.dart';
import 'package:mined_2025/client/utils/widgets/navbar/custom_button.dart';
import 'package:mined_2025/client/utils/widgets/navbar/navbar_button.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  static const route = "/";
  static const fullRoute = "/";
  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  context.go('/');
                },
                child: MouseRegion(
                  cursor:SystemMouseCursors.click,
                  child: Text(
                    "L O G O",
                    style: TextStyle(
                        color: AppColors.theme['deepPurpleColor'],
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                children: [
                  NavbarButton(
                      text: "Login",
                      textColor: AppColors.theme['deepPurpleColor'],
                      hoverTextColor: AppColors.theme['deepPurpleColor'],
                      lineColor: Colors.white,
                      onTap: () {
                        context.go('/login');
                      }),
                  const SizedBox(width: 20),
                  CustomButton(
                    text: 'Register',
                    onTap: () {
                      context.go('/register');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        toolbarHeight: 100,
        flexibleSpace: Container(
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
        ),
        elevation: 0,
      ),
      body: widget.child,
    );
  }
}
