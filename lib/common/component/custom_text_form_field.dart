import 'package:actual_delivery/common/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFromField({
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      // 실제 테두리
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1.0,
      ),
    );

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      // 주로 비밀번호 입력할 때
      obscureText: obscureText,
      autofocus: autofocus,
      // 값이 변경될 때 마다 실행되는 콜백
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20.0),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14.0,
        ),
        fillColor: INPUT_BG_COLOR,
        // false - 배경색 없음, true - 배경색 있음
        filled: true,
        // 모든 Input 상태의 기본 스타일 세팅
        border: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }
}
