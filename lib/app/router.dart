import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/ui/views/home_view/home_view.dart';
import 'package:tracking_app/ui/views/login_view/login_view.dart';
import 'package:tracking_app/ui/views/order_details/order_details_view.dart';
import 'package:tracking_app/ui/views/order_tracking_page/order_tracking_page_view.dart';
import 'package:tracking_app/ui/views/startup_logic_view/startup_logic_view.dart';

import '../helpers/constants/routes_name.dart';

GoRouter router() {
  return GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: 'startup',
        path: AppRoutes.startUp,
        builder: (BuildContext context, GoRouterState state) =>
            const StartupLogicView(),
      ),
      GoRoute(
        name: AppRoutes.loginView,
        path: AppRoutes.loginView,
        builder: (BuildContext context, GoRouterState state) => LoginView(),
      ),
      GoRoute(
        name: AppRoutes.homeView,
        path: AppRoutes.homeView,
        builder: (BuildContext context, GoRouterState state) => HomeView(),
      ),
      GoRoute(
        name: AppRoutes.orderDetailsView,
        path: AppRoutes.orderDetailsView,
        builder: (BuildContext context, GoRouterState state) =>
            OrderDetailsView(orderId: state.extra as int),
      ),
      GoRoute(
        name: AppRoutes.orderTrackingPageView,
        path: AppRoutes.orderTrackingPageView,
        builder: (BuildContext context, GoRouterState state) =>
            OrderTrackingPageView(
          orderId: state.extra as int,
        ),
      ),
    ],
  );
}
