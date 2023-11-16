import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:tracking_app/helpers/utils/build_context/text_theme.dart';
import 'package:tracking_app/ui/views/order_tracking_page/order_tracking_page_viewmodel.dart';

import '../../../helpers/constants/colors.dart';

class OrderTrackingPageView extends StatelessWidget {
  OrderTrackingPageView({super.key, required this.orderId});
  final int orderId;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderTrackingPageViewModel>.reactive(
        viewModelBuilder: () => OrderTrackingPageViewModel(),
        onViewModelReady: (model) => model.getOrderById(orderId),
        builder: (context, model, child) => Scaffold(
              backgroundColor: AppColors.primaryBackground,
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () => context.pop(),
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.white,
                  ),
                ),
                backgroundColor: AppColors.black,
                title: Text(
                  'Order Progress',
                  style: context.textTheme.titleSmall
                      ?.copyWith(color: AppColors.white),
                ),
              ),
              body: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      ...?model.order?.orderStatusUpdates
                          .map((status) => StatusIndicator(
                                status: status.status.name,
                                isCompleted: model.order!.orderStatusUpdates
                                        .indexOf(status) <
                                    3, // Example: Completed statuses
                              ))
                          .toList()
                    ],
                  ),
                ),
              ),
            ));
  }
}

class StatusIndicator extends StatelessWidget {
  final String status;
  final bool isCompleted;
  const StatusIndicator(
      {super.key, required this.status, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 50,
          child: Column(
            children: [
              Container(
                width: 4,
                height: 50,
                color:
                    isCompleted ? Colors.green : Colors.grey, // Vertical line
              ),
              Icon(
                isCompleted ? Icons.check : Icons.circle,
                color: isCompleted
                    ? Colors.green
                    : Colors.grey, // Check or box icon
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status,
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Additional details or timestamp here', // You can add details or timestamps
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
