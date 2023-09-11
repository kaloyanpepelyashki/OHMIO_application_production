import 'package:flutter/material.dart';


class GridLayout extends StatefulWidget {
  const GridLayout({super.key});

  @override
  State<GridLayout> createState() => _GridLayoutState();
}

class Element {
  late String title;
  late int randomIndex;

  Element(this.title, this.randomIndex);
}

class _GridLayoutState extends State<GridLayout> {
  List<Element> elements = [
  Element("Test item 1", 12),
  Element("Test item 2", 44),
  Element("Test item 3", 420),
  //Elements("Test item 4", 440)
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
        children: const [
          //for (final el in elements)
            /*GridItem(
              title: el.title,
              randomIndex: el.randomIndex,
            ),*/
        ],
      ),
    )
  ]);
}
}