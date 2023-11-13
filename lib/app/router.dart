import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:tracking_app/ui/views/login_view/login_view.dart';
import 'package:tracking_app/ui/views/startup_logic_view/startup_logic_view.dart';

import '../helpers/constants/routes_name.dart';

GoRouter router() {
  return GoRouter(
      routes: <GoRoute>[
        GoRoute(
          name: 'startup',
          path: AppRoutes.startUp,
          builder: (BuildContext context, GoRouterState state) => StartupLogicView(),
        ),
        GoRoute(
          name:AppRoutes.loginView,
          path: AppRoutes.loginView,
          builder: (BuildContext context, GoRouterState state) => LoginView(),
        ),
      ],
      );
}
