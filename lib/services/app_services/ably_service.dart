import 'dart:convert';

import 'package:ably_flutter/ably_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:ably_flutter/ably_flutter.dart' as ably;
import 'package:tracking_app/app/locator.dart';
import 'package:tracking_app/services/app_services/order_service.dart';

import '../../models/enum/order_status_enum.dart';

class AblyServiceClass with ListenableServiceMixin {
  final _connectionIsOpen = ReactiveValue<bool>(false);
  ReactiveValue<bool> get connectionIsOpen => _connectionIsOpen;
  ably.ClientOptions? clientOptions;
  ably.Realtime? realtime;
  RealtimeChannel? _channel;

  AblyServiceClass() {
    clientOptions = ably.ClientOptions(
      key: 'ZDMybw.6Yieqg:rXXZpq3Jl2Nb8pk_LvkMIsd_81yHeAOabYkgzb4i5K0',
      clientId: 'sample_client',
    );
    realtime = ably.Realtime(options: clientOptions);
  }

  void subscribeToOrderChannel(int orderId) async {
    if (realtime != null) {
      _channel = realtime?.channels.get('order_$orderId');
      _channel?.subscribe().listen((event) {
        _handleIncomingMessage(event);
      });
    }
  }

  void _handleIncomingMessage(Message message) {
    print("${message.name}");
    print("${message.timestamp}");
    print("${message.data}");
    final Map<String, dynamic> data = json.decode(message.data.toString());
    if (data.containsKey('orderId') && data.containsKey('status')) {
      final int orderId = data['orderId'] as int;
      final String statusString = data['status'] as String;
      OrderStatus? newStatus;
      try {
        newStatus = OrderStatus.values.firstWhere(
          (element) => element.toString() == 'OrderStatus.$statusString',
        );
      } catch (e) {
        print('Invalid status: $statusString');
      }

      if (newStatus != null) {
        locator<OrderServices>()
            .updateOrderStatus(orderId, newStatus, message.timestamp);
      }
    }
  }

  Future<void> getOrderUpdateHistory() async {
    PaginatedResult<Message>? history =
        await _channel?.history(ably.RealtimeHistoryParams(
      direction: 'forwards',
      limit: 10,
    ));
    if (history != null) {
      // Process the history data
      print('Channel history: ${history.items}');
    } else {
      print('No channel history found');
    }
  }

  Future<void> openConnection() async {
    try {
      if (realtime == null) {
        realtime = ably.Realtime(options: clientOptions);
        realtime?.connect();
        realtime?.connection
            .on()
            .listen((ably.ConnectionStateChange stateChange) async {
          _connectionIsOpen.value = true;
          print(stateChange.current.name);
        });
      }
      if (realtime != null) {
        if (realtime?.connection.state == ConnectionState.suspended) {
          realtime?.connect();
        }
      }
      subscribeToOrderChannel(1);
    } catch (e) {}
  }
}
