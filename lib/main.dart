import 'package:flutter/material.dart' ;


class MyWebsite extends StatefulWidget {
  const MyWebsite({super.key});

  @override
  State<MyWebsite> createState() => _MyWebsiteState();
}

class _MyWebsiteState extends State<MyWebsite> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

      ),
    );
  }
}
