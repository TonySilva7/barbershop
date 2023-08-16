import 'package:asyncstate/widget/async_state_builder.dart';
import 'package:barbershop/src/core/ui/theme/barbershop_theme.dart';
import 'package:barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbershop/src/features/auth/login/login_page.dart';
import 'package:barbershop/src/features/splash/splash_page.dart';
import 'package:flutter/material.dart';

class BarberShopApp extends StatelessWidget {
  const BarberShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
      customLoader: const BarbershopLoader(),
      builder: (asyncNavigatorObserver) {
        return MaterialApp(
          navigatorObservers: [asyncNavigatorObserver],
          title: 'Barber Shop',
          theme: BarbershopTheme.themeData,
          routes: {
            '/': (context) => const SplashPage(),
            '/auth/login': (context) => const LoginPage(),
          },
        );
      },
    );
  }
}
