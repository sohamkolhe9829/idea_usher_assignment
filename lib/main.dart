import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:idea_usher_assignment/theme_service.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Idea Usher Assignment",
      initialRoute: AppPages.INITIAL,
      themeMode: ThemeMode.system,
      theme: ThemeService().lightTheme,
      darkTheme: ThemeService().darkTheme,
      getPages: AppPages.routes,
    ),
  );
}
