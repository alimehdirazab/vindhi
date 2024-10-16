import 'package:flutter/material.dart';

class LoanCard extends StatelessWidget {
  final String label;
  final String imagePath;
  final void Function()? onTap;
  const LoanCard(
      {super.key, required this.label, required this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(imagePath, height: 50, width: 50),
          Text(
            label,
            style: const TextStyle(
                color: Color.fromARGB(255, 0, 24, 65), fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
