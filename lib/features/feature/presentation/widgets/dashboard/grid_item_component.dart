import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GridItem extends StatelessWidget {
  final bool? isActuator;
  final String? sensorName;
  final String? sensorImage;
  final String? sensorDescription;

  const GridItem(
      {super.key,
      this.isActuator,
      this.sensorName,
      this.sensorImage,
      this.sensorDescription});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          color: isActuator! ? Colors.lightBlue : Colors.green[200],
          child: Column(
            children: [
              sensorImage == null
                  ? SizedBox()
                  : Image.network(
                      sensorImage!,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
              Text(
                sensorName == null ? "" : sensorName!,
              ),
              Text(sensorDescription == null ? "" : sensorDescription!)
            ],
          ),
        ),
        onTap: () {
          GoRouter.of(context).push("/sensorPage");
        });
  }
}
