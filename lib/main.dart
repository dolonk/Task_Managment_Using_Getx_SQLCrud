import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:task_mnagment/db/db_helper.dart';

import 'package:task_mnagment/services/theme_services.dart';
import 'package:task_mnagment/ui/home_page/home_page.dart';
import 'package:task_mnagment/ui/theme.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.intDb();
  await GetStorage.init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeServices().theme,
        home: const HomePage());
  }

}


