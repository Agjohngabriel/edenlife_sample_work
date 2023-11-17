import 'package:stacked/stacked.dart';

import '../../../app/locator.dart';
import '../../../models/order_model.dart';
import '../../../services/app_services/order_service.dart';

class OrderTrackingPageViewModel extends ReactiveViewModel {
  final _orderService = locator<OrderServices>();
  Order? _order;
  Order? get order => _order;

  void getOrderById(int id) {
    final result = _orderService.getOrder(id);
    _order = result;
    notifyListeners();
  }

  String getCaptionByStatusName(String status) {
    switch (status) {
      case "ORDER_PLACED":
        return "Order has been placed";
      case "ORDER_ACCEPTED":
        return "Order has been accepted";
      case "ORDER_PICK_UP_IN_PROGRESS":
        return "Order pick-up is in progress";
      case "ORDER_ON_THE_WAY_TO_CUSTOMER":
        return "Order is on the way to the customer";
      case "ORDER_ARRIVED":
        return "Order has arrived";
      case "ORDER_DELIVERED":
        return "Order has been delivered";
      default:
        return "Order has been placed";
    }
  }

  void addListenerToOrder(int id) {
    _orderService.addListener(() {
      _order = _orderService.getOrder(id);
      notifyListeners();
    });
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_orderService];
}
