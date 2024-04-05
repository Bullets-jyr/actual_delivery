import 'package:actual_delivery/common/view/splash_screen.dart';
import 'package:flutter/material.dart';

import 'user/view/login_screen.dart';

void main() {
  runApp(
    _APP(),
  );
}

class _APP extends StatelessWidget {
  const _APP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
