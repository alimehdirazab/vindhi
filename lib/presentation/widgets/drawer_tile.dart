import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vindhi_app/core/ui.dart';

class DrawerTile extends StatelessWidget {
  final IconData? icon;
  final String title;
  final void Function()? onTap;
  const DrawerTile(
      {super.key, required this.icon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.primaryColor),
          ),
          child: ListTile(
            leading: Icon(
              icon,
              color: const Color.fromARGB(255, 20, 133, 24),
              size: 30,
            ),
            title: Text(
              title,
            ),
          ),
        ),
      ),
    );
  }
}
