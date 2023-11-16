import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:tracking_app/app/locator.dart';
import 'package:tracking_app/helpers/constants/routes_name.dart';
import 'package:tracking_app/services/app_services/ably_service.dart';
import 'package:tracking_app/services/app_services/auth_service.dart';
import 'package:tracking_app/services/app_services/order_service.dart';

import '../../../models/order_model.dart';

class HomeViewModel extends ReactiveViewModel implements Initialisable {
  final _orderService = locator<OrderServices>();
  final _ablyService = locator<AblyServiceClass>();
  User? get user => locator<AuthService>().currentUser;
  List<Order> get orders => _orderService.orders;
  void goToOrderDetail(int id) {
    locator<GoRouter>().push(AppRoutes.orderDetailsView, extra: id);
  }

  @override
  void initialise() {
    locator<OrderServices>().mockOrders();
    _ablyService.openConnection();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_orderService];
}
