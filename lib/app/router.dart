import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../helpers/constants/routes_name.dart';

GoRouter router() {
  return GoRouter(
      routes: <GoRoute>[
        GoRoute(
          name: 'startup',
          path: AppRoutes.startUp,
          builder: (BuildContext context, GoRouterState state) => Container(),
        ),
      ],
      );
}
