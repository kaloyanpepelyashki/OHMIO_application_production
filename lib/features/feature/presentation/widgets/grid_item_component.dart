import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final String title;
  final int randomIndex;
  const GridItem({super.key, required this.title, required this.randomIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green[200],
        child: Column(
          children: [Text(title), Text(randomIndex.toString())],
        ));
    ;
  }
}
