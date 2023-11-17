import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:tracking_app/app/locator.dart';
import 'package:tracking_app/helpers/utils/build_context/text_theme.dart';
import 'package:tracking_app/models/enum/order_status_enum.dart';
import 'package:tracking_app/services/app_services/order_service.dart';
import 'package:tracking_app/ui/views/order_tracking_page/order_tracking_page_viewmodel.dart';

import '../../../helpers/constants/colors.dart';

class OrderTrackingPageView extends StatelessWidget {
  const OrderTrackingPageView({super.key, required this.orderId});
  final int orderId;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderTrackingPageViewModel>.reactive(
        viewModelBuilder: () => OrderTrackingPageViewModel(),
        onViewModelReady: (model) {
          model.getOrderById(orderId);
          model.addListenerToOrder(orderId);
        },
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
                  'Track Order',
                  style: context.textTheme.titleSmall
                      ?.copyWith(color: AppColors.white),
                ),
              ),
              body: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat.MMMd()
                                      .add_y()
                                      .format(model.order!.orderDate),
                                  style: context.textTheme.labelLarge,
                                ),
                                Text(
                                  "Order Id: ${model.order?.orderId}",
                                  style: context.textTheme.labelLarge,
                                ),
                              ],
                            ),
                            Text(
                              "Amt: \$ ${model.order?.orderPrice}",
                              style: context.textTheme.titleLarge?.copyWith(
                                  color: AppColors.text60,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ...OrderStatus.values.map((status) {
                        final isCompleted = model.order?.orderStatusUpdates
                                .any((update) => update.status == status) ??
                            false;
                        DateTime? timeStamp;
                        if (isCompleted) {
                          final update = model.order?.orderStatusUpdates
                              .firstWhere((update) => update.status == status);
                          timeStamp = update?.timestamp;
                        }
                        return StatusIndicator(
                          status: status.name,
                          isCompleted: isCompleted,
                          timeStamp: timeStamp,
                          caption: locator<OrderServices>()
                              .getCaptionByStatusName(
                                  status.name), // Example: Completed statuses
                        );
                      }).toList()
                    ],
                  ),
                ),
              ),
            ));
  }
}

class StatusIndicator extends StatelessWidget {
  final String? status;
  final bool isCompleted;
  final DateTime? timeStamp;
  final String caption;
  const StatusIndicator(
      {super.key,
      required this.status,
      required this.isCompleted,
      this.timeStamp,
      required this.caption});

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
                height: 30,
                color: isCompleted
                    ? Colors.green
                    : Colors.grey.withOpacity(0.4), // Vertical line
              ),
              Icon(
                isCompleted ? Icons.check : Icons.circle,
                color: isCompleted
                    ? Colors.green
                    : Colors.grey.withOpacity(0.4), // Check or box icon
              ),
              Container(
                width: 4,
                height: 30,
                color: isCompleted
                    ? Colors.green
                    : Colors.grey.withOpacity(0.4), // Vertical line
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$status",
                    style: context.textTheme.titleMedium?.copyWith(
                        color: isCompleted
                            ? AppColors.text60
                            : AppColors.textgrey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    caption,
                    style: context.textTheme.labelMedium?.copyWith(
                        color: isCompleted
                            ? AppColors.text50
                            : AppColors.textgrey),
                  ),
                  const SizedBox(height: 8),
                  timeStamp == null
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            DateFormat('hh:mm a').format(timeStamp!),
                            style: context.textTheme.labelSmall,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
