import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:news/navigation/app_router.gr.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        InfosRoute(),
        RegisterRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const [
            BottomNavigationBarItem(
              label: 'Acutalités',
              icon: Icon(Icons.newspaper_outlined),
              activeIcon: Icon(Icons.newspaper),
            ),
            BottomNavigationBarItem(
              label: 'Infos',
              icon: Icon(Icons.info_outline),
            ),
            BottomNavigationBarItem(
              label: 'Inscription',
              icon: Icon(Icons.account_circle_outlined),
            ),
          ],
        );
      },
    );
  }
}