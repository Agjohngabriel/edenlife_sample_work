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

  void addListenerToOrder(int id) {
    _orderService.addListener(() {
      _order = _orderService.getOrder(id);
      notifyListeners();
    });
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_orderService];
}
