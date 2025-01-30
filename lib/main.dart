import 'package:flutter/material.dart' ;
import 'package:mined_2025/client/pages/landing_page/main_layout.dart';
import 'client/router/router.dart';


late Size mq ;

void main(){
  runApp(MyWebsite());
}

class MyWebsite extends StatefulWidget {
  const MyWebsite({super.key});

  @override
  State<MyWebsite> createState() => _MyWebsiteState();
}

class _MyWebsiteState extends State<MyWebsite> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
