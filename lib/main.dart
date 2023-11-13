import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'app/app.dart';
import 'app/locator.dart';
import 'firebase_options.dart';

void main() {
  run();
}

void run() async {
  runZonedGuarded(() async {
    debugRepaintRainbowEnabled = false;
    WidgetsFlutterBinding.ensureInitialized();
    await setUpLocator();
    runApp(TrackingApp());
  }, (error, stack) {});
}
