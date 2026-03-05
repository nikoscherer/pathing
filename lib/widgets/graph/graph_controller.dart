import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pathing/algorithms/algorithm.dart';
import 'package:pathing/algorithms/bfs.dart';
import 'package:pathing/algorithms/dfs.dart';
import 'package:pathing/models/node_model.dart';
import 'package:pathing/widgets/algorithms/algorithm_dropdown.dart';
import 'package:pathing/widgets/graph/graph_builder.dart';

class GraphController extends ChangeNotifier {
  DrawType drawType = DrawType.start;
  AlgorithmType algorithmType = AlgorithmType.bfs;

  List<NodeModel> nodes = [];
  NodeModel? startNode;
  NodeModel? targetNode;

  int width = 10;
  int height = 10;

  Algorithm? algorithm;
  double speed = 1;

  GraphController() {
    _generate();
  }

  void setDrawType(DrawType type) {
    drawType = type;
    notifyListeners();
  }

  void setAlgorithmType(AlgorithmType type) {
    algorithmType = type;
    restart();
    notifyListeners();
  }

  void setSpeed(double newSpeed) {
    speed = newSpeed;
    restart();
  }

  void _initializeAlgorithm() {
    if (algorithm != null) return;

    switch (algorithmType) {
      case AlgorithmType.bfs:
        algorithm = BFS(
          nodes: nodes,
          startNode: startNode!,
          targetNode: targetNode!,
        );
        break;
      case AlgorithmType.dfs:
        algorithm = DFS(
          nodes: nodes,
          startNode: startNode!,
          targetNode: targetNode!,
        );
        break;
    }
  }

  void restart() {
    for (var node in nodes) {
      node.visited = false;
    }
    algorithm?.timer?.cancel();
    algorithm = null;
    notifyListeners();
  }

  void pause() {
    algorithm?.isRunning = false;
  }

  void step() {
    _initializeAlgorithm();
    algorithm!.step();
    notifyListeners();
  }

  void run() {
    if (startNode == null || targetNode == null) return;

    _initializeAlgorithm();
    if (algorithm!.isRunning) return;

    algorithm!.isRunning = true;
    _startTimer();
  }

  void handleTap(int index) {
    if (algorithm?.isRunning ?? false) {
      restart();
    }

    NodeModel node = nodes[index];

    switch(drawType) {
      case DrawType.toggle:
        if (node.type == NodeType.start || node.type == NodeType.target || node.type == NodeType.inactive) {
          node.type = NodeType.active;
        } else {
          node.type = NodeType.inactive;
        }
        break;
      case DrawType.start:
        startNode?.type = NodeType.active;
        node.type = NodeType.start;
        startNode = node;
        break;
      case DrawType.target:
        targetNode?.type = NodeType.active;
        node.type = NodeType.target;
        targetNode = node;
        break;
    }

    drawType = DrawType.toggle;
    notifyListeners();
  }

  void _startTimer() {
    if (algorithm!.timer != null) return;
    algorithm!.timer = Timer.periodic(
      Duration(milliseconds: (100 / speed).round()), 
      (_) {
        if (!algorithm!.isRunning) return;
        algorithm!.step();
        notifyListeners();
      }
    );
  }

  void _generate() {
    nodes = GraphBuilder.build(10, 10);
    startNode = null;
    targetNode = null;
    notifyListeners();
  }
}