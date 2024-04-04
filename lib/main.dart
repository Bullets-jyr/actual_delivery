import 'package:flutter/material.dart';

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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(),
      ),
    );
  }
}

