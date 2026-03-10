import 'package:flutter/material.dart';
import 'package:pathing/models/node_model.dart';
import 'package:pathing/widgets/graph/notifiers/graph_controller.dart';

class GraphPainter extends CustomPainter {
  GraphController controller;

  GraphPainter({required this.controller}) :super(repaint: controller);

  void _drawGrid(Canvas canvas, Size size) {
    Paint paint = Paint()
    ..color = const Color.fromARGB(255, 86, 86, 86);

    double spacing = 50;
    int count = ((size.width > size.height? size.width : size.height) / spacing).ceil();

    for (int gridSize = -count; gridSize < count; gridSize++) {
      canvas.drawLine(
        Offset(-size.width, gridSize.toDouble() * spacing),
        Offset(size.width, gridSize.toDouble() * spacing),
        paint
      );

      canvas.drawLine(
        Offset(gridSize.toDouble() * spacing, -size.height),
        Offset(gridSize.toDouble() * spacing, size.height),
        paint
      );
    }
  }

  void _drawNodes(Canvas canvas, Size size) {
    Paint paint = Paint()
    ..color = const Color.fromARGB(255, 86, 86, 86);

    for (NodeModel node in controller.nodes) {
      canvas.drawCircle(node.location, 20, paint);
    }
  }
  
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(controller.zoom);
    canvas.translate(controller.pan.dx, controller.pan.dy);
    canvas.scale(1, -1);

    Paint paint = Paint()
    ..color = const Color.fromARGB(255, 86, 86, 86);
    
    _drawGrid(canvas, size);

    _drawNodes(canvas, size);

    canvas.restore();
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }  
}