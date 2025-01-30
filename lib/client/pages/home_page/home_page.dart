import 'package:flutter/material.dart';
import 'package:mined_2025/client/providers/bucket_provider.dart';
import 'package:mined_2025/client/utils/theme/theme.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const route = "/home";
  static const fullRoute = "/home";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BucketsProvider>(builder: (context, bucketProvider, child) {
      return Scaffold(
          backgroundColor: AppColors.theme['backgroundColor'],
          body: Row(
            children: [
              Container(
                width: 200,
                color: Colors.grey,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                          child: Container(
                        color: Colors.pink,
                      )),
                      Container(
                        height: 100,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 300,
                child: Column(
                  children: [
                    Container(height: 200,color: Colors.deepPurple,),
                    Expanded(child: Container(color: Colors.blue,)),
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
