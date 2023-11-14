import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';

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
