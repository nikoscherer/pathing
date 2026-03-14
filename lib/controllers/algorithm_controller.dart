import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pathing/algorithms/algorithm.dart';
import 'package:pathing/algorithms/bfs.dart';
import 'package:pathing/algorithms/dfs.dart';
import 'package:pathing/models/node_model.dart';

class AlgorithmController extends ChangeNotifier {
  AlgorithmType type = AlgorithmType.bfs;
  Algorithm? algorithm;

  List<NodeModel> visited = [];

  NodeModel? start;
  NodeModel? target;

  Timer? timer;

  bool bIsRunning = false;

  void setAlgorithm(AlgorithmType type) {
    this.type = type;
    notifyListeners();
  }

  void initialize() {
    if (start == null || target == null) return; // Notify user

    switch (type) {
      case .bfs:
        algorithm = BFS(startNode: start!, targetNode: target!);
        break;
      case .dfs:
        algorithm = DFS(startNode: start!, targetNode: target!);
        break;
    }
  }

  void play() {
    if (algorithm == null) {
      initialize();
    }

    _startTimer();
    notifyListeners();
  }

  void pause() {
    if (algorithm == null) return;

    _stopTimer();
    notifyListeners();
  }

  void restart() {
    if (algorithm == null) return;

    _stopTimer();
    for (NodeModel node in visited) {
      node.visited = false;
    }
    visited = [];
    algorithm = null;
    notifyListeners();
  }

  void step() {
    if (algorithm == null) {
      initialize();
    }
    
    algorithm!.step();
    if (!visited.contains(algorithm!.current)) {
      visited.add(algorithm!.current);
    }
    
    if (algorithm!.searched) {
      debugPrint("Finished!");
      _stopTimer();
    }
    notifyListeners();
  }

  void _stopTimer() {
    if (timer == null) return;

    timer!.cancel();
    timer = null;
  }

  void _startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 250), (_) {
      step();
    });
  }
}