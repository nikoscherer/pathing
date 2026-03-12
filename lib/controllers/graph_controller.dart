
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pathing/models/node_model.dart';

class GraphController extends ChangeNotifier {
  List<NodeModel> nodes = [];

  NodeModel? start;
  NodeModel? target;

  NodeModel? selectedNode;
  bool grabbedNode = false;

  DrawType drawType = DrawType.move;

  double zoom = 1.0;
  final double minZoom = 0.25;
  final double maxZoom = 5;

  double gridSpacing = 50;
  double nodeRadius = 50;

  Offset pan = Offset.zero;
  Size size = Size.zero;

  GraphController() {
    _generate();
  }

  void _generate() {
    nodes.add(NodeModel(index: nodes.length, location: Offset(0, 0)));
  }

  Offset toWorldCoordinates(Offset screenCoordinate) {
    return screenCoordinate
      .translate(-size.width / 2, -size.height / 2)
      .scale( 1/ zoom, -1 / zoom)
      .translate(pan.dx, pan.dy);
  }

  void selectNode(Offset position) {
    selectedNode = null;

    for (NodeModel node in nodes) {
      double dx = position.dx - node.location.dx;
      double dy = position.dy - node.location.dy;

      if (dx * dx + dy * dy <= nodeRadius * nodeRadius) {
        selectedNode = node;
        break;
      }
    }

    notifyListeners();
  }

  void moveNode(Offset location) {
    selectedNode!.location = location;
    notifyListeners();
  }

  void grabNode() {
    grabbedNode = true;
  }

  void dropNode() {
    grabbedNode = false;
  }

  void updateZoom(double newZoom, Offset newPan) {
    zoom = newZoom.clamp(minZoom, maxZoom);
    pan = newPan;
    notifyListeners();
  }

  void handleScaleStart(ScaleStartDetails details) {
    switch (drawType) {
      case .move:
        selectNode(toWorldCoordinates(details.localFocalPoint));
        grabbedNode = true;
        break;
      case .connect:

        break;
      case .add:

        break;
    }
  }

  void handleScaleUpdate(ScaleUpdateDetails details) {
    switch (drawType) {
      case .move:
      
        break;
      case .connect:

        break;
      case .add:

        break;
    }
  }
}