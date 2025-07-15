import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).scaffoldBackgroundColor == Colors.black;

    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            return !controller.showLogo.value
                ? Center(
                    child: SlideTransition(
                      position: controller.pinOffset,
                      child: Image.asset('assets/pin_icon.png', height: 90),
                    ),
                  )
                : SizedBox();
          }),
          Obx(() {
            return controller.showLogo.value
                ? Center(
                    child: FadeTransition(
                      opacity: controller.logoController,
                      child: Image.asset(
                        isDark ? 'assets/logo_dark.png' : 'assets/logo.png',
                        height: 100,
                      ),
                    ),
                  )
                : SizedBox();
          }),
          Obx(() {
            return controller.showText.value
                ? Center(
                    child: FadeTransition(
                      opacity: controller.textController,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 140.0),
                        child: Text(
                          'Fitness',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(
                              context,
                            ).textTheme.labelMedium!.color,
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox();
          }),
        ],
      ),
    );
  }
}
