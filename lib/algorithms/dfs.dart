import 'package:flutter/material.dart';
import 'package:pathing/algorithms/algorithm.dart';
import 'package:pathing/models/node_model.dart';

class DFS extends Algorithm {
  late List<NodeModel> stack;

  DFS({required super.startNode, required super.targetNode}) {
    stack = [];
    current.visited = true;
  }

  @override
  void step() {
    if (searched) {
      return;
    }

    for (NodeModel neighbor in current.getNeighbors()) {
      if (neighbor.type != NodeType.inactive && neighbor.visited == false) {
        if (!stack.contains(neighbor)) {
          stack.add(neighbor);
        }
      }
    }

    current.visited = true;

    if (stack.isEmpty) {
      debugPrint("No end node found!");
      searched = true;
      return;
    }

    current = stack.last;
    stack.removeLast();

    if (current.type == NodeType.target) {
      debugPrint("Found Node!");
      searched = true;
      current.visited = true;
      return;
    }
  }
}