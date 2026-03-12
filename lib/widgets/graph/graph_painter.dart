import 'package:flutter/material.dart';
import 'package:pathing/models/node_model.dart';
import 'package:pathing/controllers/graph_controller.dart';

class GraphPainter extends CustomPainter {
  GraphController controller;

  GraphPainter({required this.controller}) :super(repaint: controller);

  void _drawGrid(Canvas canvas, Size size) {
    Paint paint = Paint()
    ..color = const Color.fromARGB(255, 86, 86, 86);

    Offset offset = (controller.pan ~/ controller.gridSpacing) * controller.gridSpacing;

    int halfCount = 
      ((size.width > size.height? size.width : size.height)
       / (controller.gridSpacing * controller.zoom)).ceil();

    for (int row = -halfCount; row <= halfCount; row++) {
      canvas.drawLine(
        offset + Offset(-halfCount * controller.gridSpacing, row * controller.gridSpacing),
        offset + Offset(halfCount * controller.gridSpacing, row * controller.gridSpacing),
        paint,
      );
    }

    for (int col = -halfCount; col <= halfCount; col++) {
      canvas.drawLine(
        offset + Offset(col * controller.gridSpacing, -halfCount * controller.gridSpacing),
        offset + Offset(col * controller.gridSpacing, halfCount * controller.gridSpacing),
        paint,
      );
    }
  }

  void _drawNodes(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black;
    for (NodeModel node in controller.nodes) {
      Paint paint = Paint()
      ..color = node.getColor();

      canvas.drawCircle(node.location, controller.nodeRadius, paint);
    }
  }

  void _drawConnections(Canvas canvas, Size size) {

  }
  
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(controller.zoom, -controller.zoom);
    canvas.translate(-controller.pan.dx, -controller.pan.dy);
    
    _drawGrid(canvas, size);

    _drawConnections(canvas, size);
    _drawNodes(canvas, size);

    canvas.restore();
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }  
}