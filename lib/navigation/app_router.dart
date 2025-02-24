import 'package:auto_route/auto_route.dart';
import 'package:news/navigation/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: MainRoute.page,
      path: '/main',
      children: [
        AutoRoute(page: HomeRoute.page, path: 'home', initial: true),
        AutoRoute(page: InfosRoute.page, path: 'infos'),
        AutoRoute(page: RegisterRoute.page, path: 'register'),
      ],
      initial: true,
    ),
  ];
}
