
import 'package:flutter/material.dart';
import 'package:pathing/models/node_model.dart';

class GraphController extends ChangeNotifier {
  List<NodeModel> nodes = [];

  NodeModel? start;
  NodeModel? target;

  double zoom = 1.0;
  double worldScale = 10;
  double gridSpacing = 100;
  final double minZoom = 0.5;
  final double maxZoom = 5;

  Offset pan = Offset.zero;

  GraphController() {
    _generate();
  }

  void _generate() {
    nodes.add(NodeModel(index: nodes.length, location: Offset(100, 100)));
  }

  void updateZoom(double newZoom, Offset newPan) {
    zoom = newZoom.clamp(minZoom, maxZoom);
    pan = newPan;
    notifyListeners();
  }
}