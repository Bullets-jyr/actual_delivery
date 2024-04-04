import 'package:actual_delivery/common/component/custom_text_form_field.dart';
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
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFromField(
              hintText: '이메일을 입력해주세요.',
              onChanged: (String value) {},
            ),
            CustomTextFromField(
              hintText: '비밀번호를 입력해주세요.',
              obscureText: true,
              onChanged: (String value) {},
            ),
          ],
        ),
      ),
    );
  }
}
