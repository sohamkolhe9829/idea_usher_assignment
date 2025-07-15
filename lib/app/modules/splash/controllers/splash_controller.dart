import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController pinController;
  late Animation<Offset> pinOffset;
  late AnimationController logoController;
  late AnimationController textController;

  var showLogo = false.obs;
  var showText = false.obs;

  @override
  void onInit() {
    super.onInit();

    pinController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    pinOffset = Tween<Offset>(begin: Offset(0, -2), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: pinController, curve: Curves.easeOutBack),
    );

    logoController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    textController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    startAnimation();
  }

  void startAnimation() async {
    await pinController.forward();
    await Future.delayed(Duration(milliseconds: 300));
    showLogo.value = true;
    await logoController.forward();
    await Future.delayed(Duration(milliseconds: 300));
    showText.value = true;
    await textController.forward();
    await Future.delayed(Duration(seconds: 1));
    Get.offAllNamed('/home');
  }

  @override
  void onClose() {
    pinController.dispose();
    logoController.dispose();
    textController.dispose();
    super.onClose();
  }
}
