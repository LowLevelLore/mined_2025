import 'package:flutter/material.dart' ;
import 'package:mined_2025/client/utils/theme/theme.dart';
import 'package:mined_2025/main.dart';

class Person1 extends StatefulWidget {
  final String audioFile;
  const Person1({super.key, required this.audioFile});

  @override
  State<Person1> createState() => _Person1State();
}

class _Person1State extends State<Person1> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0,top: 10,bottom: 10),
              child: Container(
                height: 100,
                width: mq.width*0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 1,
                      spreadRadius: 0.1,
                      offset: Offset(0, 1),
                    ),
                  ],
                  borderRadius:BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),

                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [


                  ],
                ),
              ),
            ),
            Container(
              height: 100,
              width: 5,
              color: AppColors.theme['deepPurpleColor'],
            )
          ],
        ),

      ],
    );
  }
}
