import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../helpers/constants/routes_name.dart';
import '../../../models/order_model.dart';
import '../../../services/app_services/ably_service.dart';
import '../../../services/app_services/auth_service.dart';
import '../../../services/app_services/order_service.dart';

class OrderDetailsViewModel extends ReactiveViewModel {
  final _orderService = locator<OrderServices>();
  final _ablyService = locator<AblyServiceClass>();
  User? get user => locator<AuthService>().currentUser;
  Order? _order;
  Order? get order => _order;
  void trackOrder(int id) {
    locator<GoRouter>().push(AppRoutes.orderTrackingPageView, extra: id);
  }

  void getOrderById(int id) {
    final result = _orderService.getOrder(id);
    _order = result;
    notifyListeners();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_orderService];
}
