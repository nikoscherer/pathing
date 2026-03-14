import 'package:flutter/material.dart';
import 'package:pathing/models/node_model.dart';
import 'package:pathing/controllers/graph_controller.dart';

class GraphPainter extends CustomPainter {
  GraphController controller;

  GraphPainter({required this.controller}) : super(repaint: Listenable.merge([controller.camera, controller.selection]));

  void _drawGrid(Canvas canvas, Size size) {
    Paint paint = Paint()
    ..color = const Color.fromARGB(255, 28, 28, 28);

    Offset offset = (controller.camera.pan ~/ controller.camera.gridSpacing) * controller.camera.gridSpacing;

    int halfCount = 
      ((size.width > size.height? size.width : size.height)
       / (controller.camera.gridSpacing * controller.camera.zoom)).ceil();

    for (int row = -halfCount; row <= halfCount; row++) {
      canvas.drawLine(
        offset + Offset(-halfCount * controller.camera.gridSpacing, row * controller.camera.gridSpacing),
        offset + Offset(halfCount * controller.camera.gridSpacing, row * controller.camera.gridSpacing),
        paint,
      );
    }

    for (int col = -halfCount; col <= halfCount; col++) {
      canvas.drawLine(
        offset + Offset(col * controller.camera.gridSpacing, -halfCount * controller.camera.gridSpacing),
        offset + Offset(col * controller.camera.gridSpacing, halfCount * controller.camera.gridSpacing),
        paint,
      );
    }
  }

  void _drawNodes(Canvas canvas, Size size) {
    for (NodeModel node in controller.graph.nodes) {
      Paint paint = Paint()
      ..color = node.getColor();

      paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 25);
      canvas.drawCircle(node.position, controller.camera.nodeRadius, paint);
      paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

      canvas.drawCircle(node.position, controller.camera.nodeRadius, paint);
    }
  }

  void _drawConnections(Canvas canvas, Size size) {

    Set<NodeModel> drawnNodes = {};

    for (NodeModel node in controller.graph.nodes) {
      for (NodeModel neighbor in node.neighbors) {
        Paint paint = Paint()
        ..strokeWidth = 5
        ..color = node.visited && neighbor.visited? Color.fromARGB(255, 150, 150, 0) : const Color.fromARGB(255, 65, 65, 65);
        if (!drawnNodes.contains(neighbor)) {
          canvas.drawLine(
            node.position, 
            neighbor.position,
            paint
          );
        }
      }

      drawnNodes.add(node);
    }
  }

  void _drawPreviewConnection(Canvas canvas, Size size) {
    Paint paint = Paint()
    ..strokeWidth = 5
    ..color = const Color.fromARGB(255, 65, 65, 65);

    canvas.drawLine(
      controller.selection.connectionStart!.position,
      controller.selection.connectionPreview!,
      paint
    );
  }
  
  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.scale(controller.camera.zoom, -controller.camera.zoom);
    canvas.translate(-controller.camera.pan.dx, -controller.camera.pan.dy);
    
    _drawGrid(canvas, size);

    _drawConnections(canvas, size);

    if (controller.selection.connectionPreview != null) {
      _drawPreviewConnection(canvas, size);
    }

    _drawNodes(canvas, size);

    canvas.restore();
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }  
}