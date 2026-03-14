import 'package:flutter/material.dart';
import 'package:pathing/models/node_model.dart';

class GraphModel extends ChangeNotifier {
  final List<NodeModel> nodes = [];

  void moveNode(NodeModel node, Offset position) {
    node.position = position;
    notifyListeners();
  }

  void addNode(Offset position) {
    nodes.add(
      NodeModel(
        index: nodes.length,
        position: position
      )
    );
    notifyListeners();
  }

  void removeNode(NodeModel node) {
    nodes.remove(node);
    notifyListeners();
  }

  void connect(NodeModel a, NodeModel b) {
    a.connect(b);
    notifyListeners();
  }

  void disconnect(NodeModel a, NodeModel b) {
    a.disconnect(b);
    notifyListeners();
  }
}