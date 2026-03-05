import 'dart:async';

import 'package:pathing/models/node_model.dart';

class Algorithm {
  List<NodeModel> nodes;
  NodeModel startNode;
  NodeModel targetNode;

  late NodeModel current;

  bool searched = false;

  Timer? timer;
  bool isRunning = false;

  Algorithm({required this.nodes, required this.startNode, required this.targetNode}) {
    current = startNode;
    current.visited = true;
  }

  void step() {
    
  }
}