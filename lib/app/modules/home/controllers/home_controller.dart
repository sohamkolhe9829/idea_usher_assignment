import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health/health.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  final health = Health();

  final List<HealthDataType> types = [
    HealthDataType.STEPS,
    HealthDataType.TOTAL_CALORIES_BURNED,
  ];

  List<HealthDataPoint> stepsHealthDataList = [];
  List<HealthDataPoint> caloriesHealthDataList = [];

  double steps = 0;
  double totalCaloriesBurned = 0;

  List<HealthDataAccess> get permissions =>
      types.map((e) => HealthDataAccess.READ_WRITE).toList();

  @override
  void onInit() {
    super.onInit();
    initHealthData();
  }

  Future<void> initHealthData() async {
    await requestAllPermissions();

    bool? hasPermission = await health.hasPermissions(
      types,
      permissions: permissions,
    );

    if (!hasPermission!) {
      try {
        bool authorized = await health.requestAuthorization(
          types,
          permissions: permissions,
        );

        if (!authorized) {
          debugPrint("Health permission not granted");
          await Health().installHealthConnect().then((value) async {
            await getSteps();
            await getTotalCalories();
          });
          return;
        }
      } catch (e) {
        debugPrint("Exception during health authorization: $e");
        return;
      }
    }

    await getSteps();
    await getTotalCalories();
  }

  Future<void> requestAllPermissions() async {
    await [
      Permission.activityRecognition,
      Permission.location,
      Permission.sensors,
    ].request();
  }

  Future<void> getSteps() async {
    stepsHealthDataList.clear();
    steps = 0;
    update();

    try {
      final startTime = getDayStartEnd().start;
      final endTime = getDayStartEnd().end;

      final healthData = await health.getHealthDataFromTypes(
        types: [HealthDataType.STEPS],
        startTime: startTime,
        endTime: endTime,
      );

      final cleaned = health.removeDuplicates(healthData);
      stepsHealthDataList.assignAll(
        (cleaned.length < 100) ? cleaned : cleaned.sublist(0, 100),
      );

      for (final point in stepsHealthDataList) {
        if (point.value is NumericHealthValue) {
          steps += (point.value as NumericHealthValue).numericValue.toDouble();
        }
      }
    } catch (error) {
      debugPrint("Exception in getSteps: $error");
    }

    update();
  }

  Future<void> getTotalCalories() async {
    caloriesHealthDataList.clear();
    totalCaloriesBurned = 0;

    try {
      final healthData = await health.getHealthDataFromTypes(
        types: [HealthDataType.TOTAL_CALORIES_BURNED],
        startTime: getDayStartEnd().start,
        endTime: getDayStartEnd().end,
      );

      final cleaned = health.removeDuplicates(healthData);
      caloriesHealthDataList.assignAll(
        (cleaned.length < 100) ? cleaned : cleaned.sublist(0, 100),
      );

      for (final point in caloriesHealthDataList) {
        if (point.value is NumericHealthValue) {
          totalCaloriesBurned += (point.value as NumericHealthValue)
              .numericValue
              .toDouble();
        }
      }

      totalCaloriesBurned = double.parse(
        totalCaloriesBurned.toStringAsFixed(2),
      );
    } catch (error) {
      debugPrint("Exception in getTotalCalories: $error");
    }

    update();
  }

  DateTimeRange getDayStartEnd() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1, milliseconds: -1));
    return DateTimeRange(start: startOfDay, end: endOfDay);
  }
}
