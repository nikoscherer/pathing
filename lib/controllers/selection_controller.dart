import 'package:flutter/material.dart';
import 'package:pathing/models/node_model.dart';

class SelectionController extends ChangeNotifier {
  NodeModel? selectedNode;
  bool bNodeGrabbed = false;
  
  NodeModel? connectionStart;
  Offset? connectionPreview;

  void select(NodeModel node) {
    selectedNode = node;
    notifyListeners();
  }

  void startConnection(NodeModel node) {
    connectionStart = node;
    notifyListeners();
  }

  void updateConnection(Offset position) {
    connectionPreview = position;
    notifyListeners();
  }

  void endConnection() {
    connectionStart = null;
    connectionPreview = null;
    notifyListeners();
  }

  bool hasNode() {
    return selectedNode != null && bNodeGrabbed;
  }
}