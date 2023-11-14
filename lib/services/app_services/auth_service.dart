import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:tracking_app/app/locator.dart';
import 'package:tracking_app/helpers/constants/routes_name.dart';

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

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    setSignInAccount(null);
    locator<GoRouter>().go(AppRoutes.loginView);
  }

  Future<void> onAppStart() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setSignInAccount(user);
    }
    notifyListeners();
  }
}
