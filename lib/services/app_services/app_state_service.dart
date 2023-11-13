import 'package:stacked/stacked.dart';

import '../../app/locator.dart';
import '../../helpers/constants/local_storage_keys.dart';
import '../../models/app_state.dart';
import '../core/local_storage_service.dart';

class AppStateService with ListenableServiceMixin {
  final _storage = locator<LocalStorageService>();
  final _state = ReactiveValue<AppState>(AppState());

  AppStateService() {
    listenToReactiveValues([_state]);
  }

  bool get loginState => _state.value.isLogged;

  set loginState(bool state) {
    _storage.saveDataToDisk(Keys.loginKey, state);
    _state.value.isLogged = state;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    _state.value.isLogged = _storage.getDataFromDisk(Keys.loginKey) ?? false;
    notifyListeners();
  }
}
