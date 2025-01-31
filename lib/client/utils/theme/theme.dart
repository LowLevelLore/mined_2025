import 'package:flutter/material.dart';

hexStringToColors(String hexColor){
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }

  return Color(int.parse(hexColor, radix: 16));
}


class  AppColors {
  static Map theme = themes["theme1"];

  static Map themes = {

    "theme1": {
      "bgGradient1Color":hexStringToColors("FF5F0F40"),
      "bgGradient2Color":hexStringToColors("#FF310E68"),
      "deepPurpleColor" :Colors.deepPurpleAccent,
      "secondaryColor":hexStringToColors("#FFFFFF"),
    },
  };


}