import 'package:flutter/material.dart' ;
import 'package:mined_2025/client/utils/theme/theme.dart';
import 'package:mined_2025/main.dart';


class Person2 extends StatefulWidget {
  final String audioFile; // This should now be the path to the .mp3 file

  const Person2({super.key, required this.audioFile});

  @override
  State<Person2> createState() => _Person2State();
}

class _Person2State extends State<Person2> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 5,
              color: AppColors.theme['podcastColor'],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0,top: 10,bottom: 10),
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
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),

                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [


                  ],
                ),
              ),
            ),
          ],
        ),

      ],
    );
  }
}
