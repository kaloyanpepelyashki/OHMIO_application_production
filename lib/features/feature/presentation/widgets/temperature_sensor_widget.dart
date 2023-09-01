import 'dart:convert';
import 'dart:math';

import 'package:dart_either/dart_either.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_tunnel_application_production/features/feature/domain/entities/pintunnel_data_class.dart';
import 'package:pin_tunnel_application_production/features/feature/presentation/bloc/PinTunnelBloc.dart';

import '../bloc/PinTunnelState.dart';

class TemperatureSensorWidget extends StatefulWidget {
  const TemperatureSensorWidget({super.key});

  @override
  State<TemperatureSensorWidget> createState() =>
      _TemperatureSensorWidgetState();
}

class _TemperatureSensorWidgetState extends State<TemperatureSensorWidget> {
  final double minValue = 5;

  final double maxValue = 30;

  double value = 35;

  late double minuteValue;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinTunnelBloc, PinTunnelState>(
      listener: (context, state) {},
      builder: (context, state) {
        double value = this.value;
        if (state is PayloadReceivedState) {
          value = state.payload['new']['data'];
       }
        if (state is MinutePayloadReceivedState){
          print('payload in widget');
            minuteValue = state.payload['new']['avg'];
        }
        return SizedBox(
          width: 500,
          height: 500,
          child: Row(
            children: [
              const Expanded(
                child: Icon(Icons.ac_unit, color: Colors.blue, size: 50),
              ),
              Expanded(
                child: Center(
                    child: CustomCircle(
                        minValue: minValue, maxValue: maxValue, value: value)),
              ),
              const Expanded(
                child: Icon(Icons.whatshot, color: Colors.red, size: 50),
              )
            ],
          ),
        );
      },
    ); // Set the middle value here
  }
}

class CustomCircle extends StatelessWidget {
  final double minValue;
  final double maxValue;
  final double value;
  CustomCircle(
      {required this.minValue, required this.maxValue, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: CirclePainter(minValue, maxValue, value),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double minValue;
  final double maxValue;
  final double value;

  CirclePainter(this.minValue, this.maxValue, this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = min(size.width / 2, size.height / 2);

    _paintCenterText(canvas, center, value);

    Paint paint = Paint();
    paint.color = Colors.grey;
    paint.strokeWidth = 5;
    //PaintingStyle.stroke- paints only the edge of circle
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paint);

    final double smallRadius = min(size.width / 2.5, size.height / 2.5);
    canvas.drawCircle(center, smallRadius, paint);

    List<double> displayValues = [minValue, maxValue];
    for (double i in displayValues) {
      double angle = 2 * pi * (i / 100) + pi;
      Offset textOffset = Offset(center.dx + (radius + 22) * cos(angle),
          center.dy + (radius + 22) * sin(angle));
      TextSpan span = TextSpan(
          style: TextStyle(
              color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
          text: '$i');
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, textOffset - Offset(tp.width / 2, tp.height / 2));
    }

    Paint highlightPaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

// RED ARC
    highlightPaint.color = Colors.red;
    double maxStartAngle = 2 * pi * (maxValue / 100) + pi;
    double maxEndAngle = 5 * pi / 4 - 2 * pi * (maxValue / 100);
    _drawFilledArc(canvas, center, radius, smallRadius, maxStartAngle,
        maxEndAngle, highlightPaint, "red");

    // BLUE ARC
    highlightPaint.color = Colors.blue;
    double minStartAngle = 3 * pi / 4;
    double minEndAngle = 2 * pi * (minValue / 100) + pi / 4;
    _drawFilledArc(canvas, center, radius, smallRadius, minStartAngle,
        minEndAngle, highlightPaint, "blue");

    // GREEN ARC
    highlightPaint.color = Colors.green;
    double betweenStartAngle = 2 * pi * (minValue / 100) + pi;
    double betweenEndAngle = maxStartAngle - betweenStartAngle;
    _drawFilledArc(canvas, center, radius, smallRadius, betweenStartAngle,
        betweenEndAngle, highlightPaint, "green");

    /*
    // Draw full circle
    Paint circlePaint = Paint()..color = Colors.grey..style = PaintingStyle.stroke..strokeWidth = 5;
    canvas.drawCircle(center, radius, circlePaint);

    // Draw highlighted sections
    Paint highlightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    // Below minValue highlight
    highlightPaint.color = Colors.blue;
    double minStartAngle = 2 * pi * 0;  // This starts at the beginning of the circle (0 value)
    double minEndAngle = 2 * pi * (minValue / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, minEndAngle, false, highlightPaint);

  

    // Draw arrow pointing to value
    double arrowAngle = 2 * pi * (minValue / 100);
    double arrowLength = radius;
    Offset endOffset = Offset(center.dx + arrowLength * cos(arrowAngle), center.dy + arrowLength * sin(arrowAngle));
    
    canvas.drawLine(center, endOffset, Paint()..color = Colors.black..strokeWidth = 3);

    // Draw incremental values around the circle
    final double increment = 10;  // Change this value if you want more or fewer increments
    for (double i = 0; i <= 100; i += increment) {
      double angle = 2 * pi * (i / 100);
      Offset textOffset = Offset(center.dx + (radius + 15) * cos(angle), center.dy + (radius + 15) * sin(angle));
      TextSpan span = TextSpan(style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold), text: '$i');
      TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, textOffset - Offset(tp.width/2, tp.height/2));
    }
*/
  }

  void _drawFilledArc(
      Canvas canvas,
      Offset center,
      double outerRadius,
      double innerRadius,
      double startAngle,
      double sweepAngle,
      Paint paint,
      String color) {
    Path path = Path()
      ..moveTo(center.dx + innerRadius * cos(startAngle),
          center.dy + innerRadius * sin(startAngle))
      ..arcTo(Rect.fromCircle(center: center, radius: innerRadius), startAngle,
          sweepAngle, false)
      ..lineTo(center.dx + outerRadius * cos(startAngle + sweepAngle),
          center.dy + outerRadius * sin(startAngle + sweepAngle))
      ..arcTo(Rect.fromCircle(center: center, radius: outerRadius),
          startAngle + sweepAngle, -sweepAngle, false)
      ..close();

    // Compute bounding rectangle for gradient
    final Rect rect = Rect.fromCircle(center: center, radius: outerRadius);

    Gradient gradient = LinearGradient(
      colors: [
        Colors.blue.shade900,
        Colors.blue.shade200
      ], // Adjust the shades as per your needs
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    if (color == "blue") {
      gradient = LinearGradient(
        colors: [
          Colors.blue.shade400,
          Colors.blue.shade700
        ], // Adjust the shades as per your needs
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
    }
    if (color == "green") {
      gradient = LinearGradient(
        colors: [
          Colors.green.shade200,
          Colors.green.shade900
        ], // Adjust the shades as per your needs
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
    }

    if (color == "red") {
      gradient = LinearGradient(
        colors: [
          Colors.red.shade100,
          Colors.red.shade900
        ], // Adjust the shades as per your needs
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
    }

    // Convert gradient into a shader
    paint.shader = gradient.createShader(rect);

    canvas.drawPath(path, paint);
  }

  void _paintCenterText(Canvas canvas, Offset center, double value) {
    String centerText = value.toString();

    // Create the TextSpan object
    TextSpan span = TextSpan(
      style: TextStyle(
          color: Colors.black, fontSize: 40.0, fontWeight: FontWeight.bold),
      text: centerText,
    );

    // Use the TextPainter to layout and draw the text
    TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout();

    // Calculate the position
    Offset textOffset = Offset(
      center.dx - (tp.width / 2),
      center.dy - (tp.height / 2),
    );

    tp.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return (oldDelegate as CirclePainter).value != value;
  }
}
