import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laundryku/src/utils/colors.dart' as custom_colors;

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.buttonType = ButtonType.fill,
    this.style,
    this.loading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final ButtonType buttonType;
  final ButtonStyle? style;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final Function() onPressedFunction = onPressed ?? () {};

    switch (buttonType) {
      case ButtonType.fill:
        return ElevatedButton(
          onPressed: onPressedFunction,
          style: style ??
              ElevatedButton.styleFrom(
                backgroundColor: custom_colors.Colors.primary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
          child: loading
              ? const CupertinoActivityIndicator(
                  color: Colors.white,
                )
              : Text(text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600)),
        );
      case ButtonType.outline:
        return OutlinedButton(
            onPressed: onPressedFunction,
            style: style ??
                OutlinedButton.styleFrom(
                  side: const BorderSide(color: custom_colors.Colors.primary),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
            child: loading
                ? const CupertinoActivityIndicator(
                    color: custom_colors.Colors.primary,
                  )
                : Text(text,
                    style: const TextStyle(
                        color: custom_colors.Colors.primary,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600)));
      case ButtonType.disabled:
        return OutlinedButton(
            onPressed: onPressedFunction,
            style: style ??
                OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
            child: Text(text,
                style: const TextStyle(
                    color: Colors.grey,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600)));
    }
  }
}

enum ButtonType { fill, outline, disabled }
