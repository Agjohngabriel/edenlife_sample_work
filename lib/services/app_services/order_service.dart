import 'package:stacked/stacked.dart';
import 'package:tracking_app/models/order_model.dart';

import '../../models/enum/order_status_enum.dart';

class OrderServices with ListenableServiceMixin {
  final _orders = ReactiveValue<List<Order>>(List<Order>.empty());
  List<Order> get orders => _orders.value;

  OrderServices() {
    listenToReactiveValues([_orders]);
  }

  void mockOrders() {
    List<Map<String, dynamic>> mockOrdersJson = [
      {
        'orderId': 1,
        'orderDate': '2023-11-15T10:30:00.000Z',
        'orderItem': 'Product A',
        'orderQuantity': 2,
        'orderPrice': 25.99,
        'status': 'ORDER_PLACED',
        "orderStatusUpdates": [
          {
            'status': OrderStatus.ORDER_PLACED,
            'timestamp': DateTime.now(),
          }
        ]
      },
    ];
    List<Order> orders =
        mockOrdersJson.map((json) => Order.fromJson(json)).toList();
    _orders.value = orders;
    notifyListeners();
  }

  Order? getOrder(int id) {
    return _orders.value.firstWhere(
      (order) => order.orderId == id,
    );
  }

  void updateOrderStatus(int id, OrderStatus newStatus, DateTime? timestamp) {
    final orderIndex = _orders.value.indexWhere((order) => order.orderId == id);
    if (orderIndex != -1) {
      final currentOrder = _orders.value[orderIndex];
      final updatedOrder = currentOrder.copyWithStatus(newStatus);
      final updatedHistory = [...updatedOrder.orderStatusUpdates];
      updatedHistory
          .add(OrderStatusUpdate(status: newStatus, timestamp: timestamp));
      _orders.value[orderIndex] = updatedOrder.copyWithHistory(updatedHistory);
      notifyListeners();
    }
  }

  void addMockOrder(Order newOrder) {
    final updatedOrders = List<Order>.from(_orders.value)..add(newOrder);
    _orders.value = updatedOrders;
    notifyListeners();
  }
}
