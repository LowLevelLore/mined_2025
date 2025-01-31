import 'package:flutter/material.dart' ;
import 'package:google_fonts/google_fonts.dart';


class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Paper",style: GoogleFonts.ebGaramond(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.deepPurple,fontSize: 25),),
        Text("2X",style: GoogleFonts.ebGaramond(fontWeight: FontWeight.bold,color: Colors.deepPurple,fontSize: 25),)
      ],
    );
  }
}
