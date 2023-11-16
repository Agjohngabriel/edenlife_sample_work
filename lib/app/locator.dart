import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tracking_app/app/router.dart';
import 'package:tracking_app/services/app_services/auth_service.dart';
import 'package:tracking_app/services/app_services/order_service.dart';

import '../services/app_services/ably_service.dart';

GetIt locator = GetIt.instance;
Future setUpLocator() async {
  locator.registerLazySingleton(() => DialogService());
  locator.registerSingleton<GoRouter>(router());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => AblyServiceClass());
  locator.registerLazySingleton(() => OrderServices());
}
