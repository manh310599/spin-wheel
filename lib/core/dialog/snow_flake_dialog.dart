import 'package:flutter/material.dart';
import 'package:spiner_wheel/utils/images.dart';
import 'package:spiner_wheel/widget/app_button.dart';

class SnowflakeDialog extends StatelessWidget {
  const SnowflakeDialog({super.key, required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Snowflakes overlaying the entire screen
        const ScrollingBackgroundScreen(),
        // Centered dialog
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.translate(
                offset: const Offset(-7, 0),
                child: Dialog(
                  insetPadding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  backgroundColor: Colors.transparent,
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      Image.asset(
                        Images.happy,
                        fit: BoxFit.fitWidth,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: double.maxFinite,
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                Images.frame,
                                width: 277,
                                fit: BoxFit.fitWidth,
                              ),
                              Transform.rotate(
                                angle: 5,
                                child: Image.asset(
                                  image,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 21,
                          ),
                          const Text(
                            'Đã quay trúng phần thưởng',
                            style:
                            TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          const Text(
                            'NGƯỜI TUYẾT',
                            style:
                            TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          AppButton.build(text: 'XEM LỊCH SỬ', onPressed: () {

                          }, image: Images.button, size: 18),
                        ],
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Transform.translate(
                          offset: const Offset(0, -20),
                          child: Image.asset(
                            Images.happyTitle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Method to build a snowflake at a specific position
  Widget _buildSnowflake(double top, double left) {
    return Positioned(
      top: top,
      left: left,
      child: Icon(
        Icons.ac_unit, // Snowflake icon
        color: Colors.white.withOpacity(0.7),
        size: 24,
      ),
    );
  }
}

class ScrollingBackgroundScreen extends StatefulWidget {
  const ScrollingBackgroundScreen({super.key});

  @override
  _ScrollingBackgroundScreenState createState() =>
      _ScrollingBackgroundScreenState();
}

class _ScrollingBackgroundScreenState extends State<ScrollingBackgroundScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(); // Repeats the animation indefinitely

    // Define the animation
    _animation = Tween<double>(begin: 1, end: 0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Image.asset(Images.constBgSnow),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    top: -screenHeight * _animation.value,
                    child: child!,
                  ),
                  Positioned(
                    top: -screenHeight * _animation.value + screenHeight,
                    child: child,
                  ),
                ],
              );
            },
            child: SizedBox(
              height: screenHeight,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                Images.bgSnow, // Replace with your image asset
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
