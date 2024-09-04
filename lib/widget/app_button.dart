import 'package:flutter/material.dart';

class AppButton {
  static Widget build({required String text, required VoidCallback onPressed,required String image,required double size}) {

    double scale = 1;

    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return  GestureDetector(
          onTap: () {
            setState(() {
              scale = 1.1;
            });
            onPressed();
            Future.delayed(const Duration(milliseconds: 100),() {
              setState(() {
                scale = 1;
              });
            },);
          },
          child: Transform.scale(
            scale: scale,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  image,
                ),
                Text(text, style: TextStyle(fontSize: size, color: Colors.white),),
              ],
            ),

          ),
        );
      },

    );
  }
}