import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:tracking_app/services/app_services/auth_service.dart';

import '../../../app/locator.dart';
import '../../../firebase_options.dart';
import '../../../helpers/constants/routes_name.dart';

class StartupLogicViewModel extends ReactiveViewModel implements Initialisable {
  final _appState = locator<AuthService>();
  final _router = locator<GoRouter>();
  void startUp() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    _appState.onAppStart();
    if (_appState.currentUser != null) {
      return _router.go(AppRoutes.homeView);
    }
    if (_appState.currentUser == null) return _router.go(AppRoutes.loginView);
  }

  @override
  // TODO: implement reactiveServices
  List<ListenableServiceMixin> get listenableServices => [
        _appState,
      ];

  @override
  void initialise() {
    startUp();
  }
}
