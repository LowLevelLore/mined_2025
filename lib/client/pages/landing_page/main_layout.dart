import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mined_2025/client/providers/bucket_provider.dart';
import 'package:mined_2025/client/utils/theme/theme.dart';
import 'package:mined_2025/client/utils/widgets/navbar/custom_button.dart';
import 'package:mined_2025/client/utils/widgets/navbar/navbar_button.dart';
import 'package:provider/provider.dart';

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
    return Consumer<BucketsProvider>(builder: (context,bucketProvider,child){
      return  Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    context.go('/');
                    bucketProvider.isLoginEnabled = false;
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
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
                        hoverTextColor: Colors.black,
                        lineColor: AppColors.theme['deepPurpleColor'],
                        isEnabled: bucketProvider.isLoginEnabled,
                        onTap: () {
                          context.go('/login');
                          bucketProvider.isLoginEnabled = true;
                          setState(() {});
                        }),
                    const SizedBox(width: 20),
                    CustomButton(
                      text: 'Register',
                      onTap: () {
                        context.go('/register');
                        bucketProvider.isLoginEnabled = false;
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
            color: AppColors.theme['backgroundColor'],
          ),
          elevation: 0,
        ),
          body: widget.child,
      );
    });
  }
}
