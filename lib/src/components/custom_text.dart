import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final CustomTextStyle style;

  const CustomText({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.style,
    );
  }
}

enum CustomTextStyle {
  title,
  heading,
  subtitle,
  content,
  light,
}

extension CustomTextStyleExtension on CustomTextStyle {
  TextStyle get style {
    switch (this) {
      case CustomTextStyle.title:
        return const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        );
      case CustomTextStyle.heading:
        return const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        );
      case CustomTextStyle.subtitle:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        );
      case CustomTextStyle.content:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        );
      case CustomTextStyle.light:
        return const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
        );
    }
  }
}
