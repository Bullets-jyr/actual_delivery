import 'package:actual_delivery/common/provider/go_router.dart';
import 'package:actual_delivery/common/view/splash_screen.dart';
import 'package:actual_delivery/user/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user/view/login_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: _APP(),
    ),
  );
}

class _APP extends ConsumerWidget {
  const _APP({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
      routerConfig: router,
    );
  }
}
