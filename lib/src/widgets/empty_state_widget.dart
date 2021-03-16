import 'package:flutter/material.dart';

Widget emptyState(BuildContext ctx) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.offline_pin_outlined,
          size: 80.0,
        ),
        Text(
          "Aun no has guardado",
          style: Theme.of(ctx).textTheme.headline1,
        ),
        SizedBox(
          height: 4.0,
        ),
        Text("Favoritos", style: Theme.of(ctx).textTheme.headline1)
      ],
    ),
  );
}
