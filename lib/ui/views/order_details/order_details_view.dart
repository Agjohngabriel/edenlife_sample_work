import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:tracking_app/helpers/utils/build_context/build_context.dart';
import 'package:tracking_app/ui/views/order_details/order_details_viewmodel.dart';

import '../../../app/locator.dart';
import '../../../helpers/constants/assets.dart';
import '../../../helpers/constants/colors.dart';
import '../../../models/enum/order_status_enum.dart';
import '../../../services/app_services/order_service.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key, required this.orderId});
  final int orderId;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderDetailsViewModel>.reactive(
        viewModelBuilder: () => OrderDetailsViewModel(),
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
                  'Sample Tracker',
                  style: context.textTheme.titleSmall
                      ?.copyWith(color: AppColors.white),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: context.heightPercent(0.1),
                    ),
                    Center(
                        child: Image.asset(
                      AppAssets.orderIcon,
                      width: context.widthPercent(0.2),
                    )),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Your order has been placed.",
                      style: context.textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      locator<OrderServices>()
                          .getCaptionByStatusName(model.order!.status.name),
                      style: context.textTheme.labelMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          ...OrderStatus.values.map((e) => Expanded(
                                child: OrderStatusProgressIndicator(
                                  isActive:
                                      model.order!.status.index >= e.index,
                                ),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () => model.trackOrder(model.order!.orderId),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Track Order",
                                style: context.textTheme.labelLarge,
                              ),
                              const Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Order Details",
                        style: context.textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Summary",
                        textAlign: TextAlign.left,
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildTextRowForOrderSummary(
                        context, "Order ID:", "${model.order?.orderId}"),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextRowForOrderSummary(
                        context,
                        "Order Date:",
                        DateFormat.MMMd()
                            .add_y()
                            .format(model.order!.orderDate)),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextRowForOrderSummary(
                        context, "Order Item:", "${model.order?.orderItem}"),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextRowForOrderSummary(context, "Order Quantity",
                        "${model.order?.orderQuantity}"),
                    const SizedBox(
                      height: 10,
                    ),
                    buildTextRowForOrderSummary(context, "Order Price:",
                        "\$${"${model.order?.orderPrice}"}"),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Delivery Address",
                        textAlign: TextAlign.left,
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "10 Ishola Jumoke Street, Ajah, Lagos State",
                          style: context.textTheme.titleSmall,
                        ))
                  ],
                ),
              ),
            ));
  }

  Row buildTextRowForOrderSummary(
      BuildContext context, String caption, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          caption,
          style:
              context.textTheme.labelMedium?.copyWith(color: AppColors.text50),
        ),
        Text(
          value,
          style:
              context.textTheme.titleSmall?.copyWith(color: AppColors.text60),
        )
      ],
    );
  }
}

class OrderStatusProgressIndicator extends StatelessWidget {
  const OrderStatusProgressIndicator({
    super.key,
    required this.isActive,
  });
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      width: 50,
      height: 8,
      decoration: BoxDecoration(
          color: isActive ? AppColors.yellow : AppColors.backgroundGrey,
          borderRadius: BorderRadius.circular(13)),
    );
  }
}
