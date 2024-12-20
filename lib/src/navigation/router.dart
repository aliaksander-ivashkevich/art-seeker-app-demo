import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';

import '../presentation/details/ui/details_screen.dart';
import '../presentation/landing/ui/landing_screen.dart';
import '../presentation/search/ui/search_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AdaptiveRoute<void>(
          initial: true,
          path: '/',
          page: LandingRoute.page,
        ),
        AdaptiveRoute<void>(
          path: '/search',
          page: SearchRoute.page,
        ),
        AdaptiveRoute<void>(
          path: '/details/:id',
          page: DetailsRoute.page,
        ),
      ];
}
