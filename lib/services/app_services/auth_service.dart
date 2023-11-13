import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked/stacked.dart';
import 'package:tracking_app/app/locator.dart';
import 'package:tracking_app/helpers/constants/routes_name.dart';

import '../../helpers/constants/local_storage_keys.dart';
import '../../models/app_state.dart';
import '../core/local_storage_service.dart';

class AuthService with ListenableServiceMixin {
  final _currentUser = ReactiveValue<User?>(null);
  User? get currentUser => _currentUser.value;
  AuthService() {
    listenToReactiveValues([_currentUser]);
  }

  void setSignInAccount(User? account) {
    _currentUser.value = account;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setSignInAccount(user);
    }
    notifyListeners();
  }
}
