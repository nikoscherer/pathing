import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:pathing/algorithms/algorithm.dart';
import 'package:pathing/models/node_model.dart';

class BFS extends Algorithm {
  late Queue<NodeModel> queue;

  BFS({required super.startNode, required super.targetNode}) {
    queue = Queue();
    current.visited = true;
  }

  @override
  void step() {
    if (searched) {
      return;
    }

    for (NodeModel neighbor in current.getNeighbors()) {
      if (neighbor.type != NodeType.inactive && neighbor.visited == false) {
        if (!queue.contains(neighbor)) {
          queue.add(neighbor);
        }
      }
    }

    current.visited = true;

    if (queue.isEmpty) {
      debugPrint("No end node found!");
      searched = true;
      return;
    }

    current = queue.first;
    queue.removeFirst();

    if (current.type == NodeType.target) {
      debugPrint("Found Node!");
      searched = true;
      current.visited = true;
      return;
    }
  }
}