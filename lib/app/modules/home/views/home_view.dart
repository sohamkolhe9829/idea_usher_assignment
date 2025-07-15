import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:idea_usher_assignment/app/modules/home/views/home_card.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hi!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 27,
            color: Theme.of(context).textTheme.labelMedium!.color,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            GetBuilder<HomeController>(
              builder: (controller) => HomeCard(
                title: "Steps",
                value: controller.steps.toInt(),
                currentSteps: controller.steps.toInt(),
                goalSteps: 400,
                darkAsset: 'assets/steps_icon_dark.png',
                lightAsset: 'assets/steps_icon_light.png',
              ),
            ),
            SizedBox(height: 20),
            GetBuilder<HomeController>(
              builder: (controller) => HomeCard(
                title: "Calories Burned",
                value: controller.totalCaloriesBurned.toInt(),
                currentSteps: controller.totalCaloriesBurned.toInt(),
                goalSteps: 700,
                darkAsset: 'assets/kcal_icon_dark.png',
                lightAsset: 'assets/kcal_icon_light.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
