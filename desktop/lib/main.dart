// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:desktop/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:desktop/utils/dark_theme.dart';
import 'package:desktop/utils/light_theme.dart';
import 'package:window_manager/window_manager.dart';
import 'package:screen_retriever/screen_retriever.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  if (Platform.isWindows) {
    var display = await screenRetriever.getPrimaryDisplay();
    var screenWidth = display.size.width;
    var screenHeight = display.size.height;

    WindowManager.instance
        .setMinimumSize(Size(screenWidth / 2, screenHeight / 2));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indoor Tracking',
      theme: light,
      darkTheme: dark,
      home: SplashScreen(),
    );
  }
}
