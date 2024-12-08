import 'package:flutter/material.dart';
import 'package:laundryku/src/utils/colors.dart' as custom_colors;

class CustomText extends StatelessWidget {
  final String text;
  final CustomTextStyle style;
  final int? maxLines;

  const CustomText({super.key, required this.text, required this.style, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.style,
      maxLines: maxLines,
    );
  }
}

enum CustomTextStyle {
  title,
  heading,
  subheading,
  subheading2,
  subtitle,
  content,
  highlight,
  light,
  tab
}

extension CustomTextStyleExtension on CustomTextStyle {
  TextStyle get style {
    switch (this) {
      case CustomTextStyle.title:
        return const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins",          
        );
      case CustomTextStyle.heading:
        return const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins",
        );
      case CustomTextStyle.subheading:
        return const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins",
        );
      case CustomTextStyle.subheading2:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: "Poppins",
        );
      case CustomTextStyle.subtitle:
        return const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
          fontFamily: "Poppins",
        );
      case CustomTextStyle.content:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
        );
      case CustomTextStyle.tab:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: "Poppins",
        );
      case CustomTextStyle.highlight:
        return const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: custom_colors.Colors.primary,
          fontFamily: "Poppins",
        );
      case CustomTextStyle.light:
        return const TextStyle(
          fontSize: 16,          
          fontWeight: FontWeight.w300,
          fontFamily: "Poppins",
        );
    }
  }
}
