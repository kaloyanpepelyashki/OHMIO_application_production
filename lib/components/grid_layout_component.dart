import 'package:flutter/material.dart';
import 'package:pin_tunnel_application_production/components/grid_item_component.dart';

class GridLayout extends StatefulWidget {
  const GridLayout({super.key});

  @override
  State<GridLayout> createState() => _GridLayoutState();
}

class Elements {
  late String title;
  late int randomIndex;

  Elements(this.title, this.randomIndex);
}

class _GridLayoutState extends State<GridLayout> {
  static List<Elements> elements = [
    Elements("Test item 1", 12),
    Elements("Test item 2", 44),
    Elements("Test item 3", 420),
    Elements("Test item 4", 440)
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(primary: false, slivers: [
      SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                for (final el in elements)
                  GridItem(
                    title: el.title,
                    randomIndex: el.randomIndex,
                  )
              ]))
    ]);
  }
}
