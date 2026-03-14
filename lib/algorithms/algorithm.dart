import 'dart:async';

import 'package:pathing/models/node_model.dart';

enum AlgorithmType {
  bfs("Breadth First Search"),
  dfs("Depth First Search");

  final String type;
  const AlgorithmType(this.type);
}

abstract class Algorithm {
  NodeModel startNode;
  NodeModel targetNode;

  late NodeModel current;

  bool searched = false;

  Timer? timer;
  bool isRunning = false;

  Algorithm({required this.startNode, required this.targetNode}) {
    current = startNode;
    current.visited = true;
  }

 void step() {}
}