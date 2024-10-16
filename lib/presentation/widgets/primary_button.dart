import 'package:flutter/material.dart';
import 'package:vindhi_app/core/ui.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Size? fixedSize;
  const PrimaryButton(
      {super.key, required this.onPressed, required this.text, this.fixedSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        fixedSize: fixedSize ?? const Size(double.infinity, 40),
      ),
      child: Text(
        text,
        style: TextStyles.body3.copyWith(color: Colors.white),
      ),
    );
  }
}
