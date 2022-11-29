import 'package:flutter/material.dart';

class AppListTile extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final IconData? icon;
  final Color? textColor;

  const AppListTile({
    super.key,
    this.onTap,
    required this.title,
    this.icon,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(icon, color: textColor),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: textColor,
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
