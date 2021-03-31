import 'package:flutter/material.dart';

Widget emptyState(
    BuildContext ctx, String text, IconData icon, String secondText) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 80.0,
        ),
        Text(
          text,
          style: Theme.of(ctx).textTheme.headline1,
        ),
        SizedBox(
          height: 4.0,
        ),
        Text(secondText, style: Theme.of(ctx).textTheme.headline1)
      ],
    ),
  );
}
