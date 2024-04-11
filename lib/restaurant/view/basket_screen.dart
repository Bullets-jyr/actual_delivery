import 'package:actual_delivery/common/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasketScreen extends ConsumerWidget {
  static String get routeName => 'basket';

  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '장바구니',
      child: Column(),
    );
  }
}
