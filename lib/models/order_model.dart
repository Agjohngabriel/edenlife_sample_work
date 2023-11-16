import 'enum/order_status_enum.dart';

class Order {
  int orderId;
  DateTime orderDate;
  String orderItem;
  int orderQuantity;
  double orderPrice;
  OrderStatus status;
  List<OrderStatusUpdate> orderStatusUpdates;

  Order({
    required this.orderId,
    required this.orderDate,
    required this.orderItem,
    required this.orderQuantity,
    required this.orderPrice,
    required this.status,
    List<OrderStatusUpdate>? orderStatusUpdates,
  }) : orderStatusUpdates = orderStatusUpdates ?? [];
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'] ?? 0,
      orderDate: DateTime.parse(json['orderDate'] ?? DateTime.now().toString()),
      orderItem: json['orderItem'] ?? '',
      orderQuantity: json['orderQuantity'] ?? 0,
      orderPrice: json['orderPrice'] ?? 0.0,
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == 'OrderStatus.${json['status']}',
        orElse: () => OrderStatus.ORDER_PLACED,
      ),
    );
  }
  Order copyWithStatus(OrderStatus newStatus) {
    return Order(
        orderId: orderId,
        orderDate: orderDate,
        orderItem: orderItem,
        orderQuantity: orderQuantity,
        orderPrice: orderPrice,
        status: newStatus,
        orderStatusUpdates: orderStatusUpdates);
  }

  Order copyWithHistory(List<OrderStatusUpdate> newHistory) {
    return Order(
      orderId: orderId,
      orderDate: orderDate,
      orderItem: orderItem,
      orderQuantity: orderQuantity,
      orderPrice: orderPrice,
      status: status,
      orderStatusUpdates: newHistory,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'orderDate': orderDate.toIso8601String(),
      'orderItem': orderItem,
      'orderQuantity': orderQuantity,
      'orderPrice': orderPrice,
      'status': status.toString().split('.').last,
      'orderStatusUpdates':
          orderStatusUpdates.map((update) => update.toJson()).toList(),
    };
  }
}

class OrderStatusUpdate {
  OrderStatus status;
  DateTime? timestamp;

  OrderStatusUpdate({required this.status, required this.timestamp});
  Map<String, dynamic> toJson() {
    return {
      'status': status.toString().split('.').last,
      'timestamp': timestamp?.toIso8601String(),
    };
  }
}
