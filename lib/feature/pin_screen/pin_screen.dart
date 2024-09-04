import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:provider/provider.dart';
import 'package:spiner_wheel/core/dialog/snow_flake_dialog.dart';
import 'package:spiner_wheel/feature/pin_screen/logic/pin_wheel_logic.dart';
import 'package:spiner_wheel/utils/images.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<PinWheelLogic>(
      create: (context) => PinWheelLogic()..init(),
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              Images.bg,
              fit: BoxFit.cover,
              width: width,
            ),
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: _body(context, width),
            ),
          ],
        ),
        floatingActionButton: Consumer<PinWheelLogic>(
          builder: (BuildContext context, PinWheelLogic value, Widget? child) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  Images.footer,
                  width: width,
                  fit: BoxFit.cover,
                ),
                GestureDetector(
                    onTap: () {
                      if(value.isSpinning) {
                        context.read<PinWheelLogic>().click(item.length - 1);
                      }
                    },
                    child: Image.asset(
                      value.image,
                      scale: context.read<PinWheelLogic>().scaleFactor,
                    ))
              ],
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

Widget _body(BuildContext context, double width) {
  return Consumer<PinWheelLogic>(
    builder: (BuildContext context, value, Widget? child) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: width,
            ),
            const SizedBox(
              height: 44.82,
            ),
            Image.asset(
              Images.titlePinter,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: width / 375 * 213,
              ),
              padding: const EdgeInsets.only(
                top: 9,
                left: 19,
                right: 19,
                bottom: 13,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFF500),
                    Color(0xFFff4d00),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: const Center(
                child: Text(
                  'Bạn còn 18 luợt quay',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (context.read<PinWheelLogic>().isSpinning) {
                  context.read<PinWheelLogic>().scroll(item.length - 1);
                }
              },
              child: Stack(
                alignment: Alignment.bottomCenter,
                fit: StackFit.loose,
                children: [
                  Image.asset(
                    Images.framePin,
                  ),
                  Transform.translate(
                    offset: const Offset(0, -22),
                    child: SizedBox(
                      height: width * 0.66,
                      width: width * 0.66,
                      child: FortuneWheel(
                        onAnimationEnd: () {
                          context.read<PinWheelLogic>().restoreSizeButton();
                          showDialog(context: context, builder: (context) {
                            return  SnowflakeDialog(image: item[0],);
                          },);
                        },
                        selected:
                            context.read<PinWheelLogic>().controller.stream,
                        indicators: [
                          FortuneIndicator(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              child: Transform.translate(
                                offset: const Offset(0, -12),
                                child: Image.asset(
                                  Images.scroll,
                                ),
                              ),
                            ),
                          ),
                        ],
                        items: item.asMap().entries.map((entry) {
                          int index = entry.key;
                          String image = entry.value;
                          return _buildFortuneItem(image, index);
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Transform.translate(
                offset: const Offset(0, -110),
                child: Image.asset(Images.carouselLegs)),
          ],
        ),
      );
    },
  );
}

FortuneItem _buildFortuneItem(String image, int index) {

  final colors = [
    const Color(0xFFFFCACE),
    const Color(0xFFFFE4E5),
  ];

  return FortuneItem(
    style: FortuneItemStyle(
      color: colors[index % colors.length],
      borderColor: Colors.transparent,
      // Lấy màu xen kẽ theo chỉ số
    ),
    child: Transform.translate(
      offset: const Offset(30, 0),
      child: Image.asset(
        image,
      ),
    ),
  );
}

final item = [
  Images.snowMan,
  Images.reindeer,
  Images.flower,
  Images.candy,
  Images.pinTree,
  Images.gift,
];

List<Widget> buildDotsAroundCircle(double radius, int count, double width) {
  return List.generate(count, (index) {
    final angle = (index * 2 * pi) / count;
    final offset = Offset(
      radius * 0.5 + (radius * 0.5 - 5) * cos(angle) - 5 + width * 0.17,
      radius * 0.5 + (radius * 0.5 - 5) * sin(angle) - 5 + width * 0.17,
    );

    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: Container(
        width: 10.0,
        height: 10.0,
        decoration: const BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
    );
  });
}
