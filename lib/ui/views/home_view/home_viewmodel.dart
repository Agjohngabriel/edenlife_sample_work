import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:tracking_app/app/locator.dart';
import 'package:tracking_app/services/app_services/auth_service.dart';

class HomeViewModel extends BaseViewModel{
  User? get user => locator<AuthService>().currentUser;
}