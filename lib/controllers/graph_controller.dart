
import 'package:flutter/material.dart';
import 'package:pathing/controllers/algorithm_controller.dart';
import 'package:pathing/controllers/camera_controller.dart';
import 'package:pathing/controllers/graph_model.dart';
import 'package:pathing/controllers/selection_controller.dart';
import 'package:pathing/controllers/tool_controller.dart';
import 'package:pathing/controllers/tools/graph_tool.dart';
import 'package:pathing/models/node_model.dart';

class GraphController {
  GraphModel graph;
  CameraController camera;
  SelectionController selection;
  ToolController tools;

  AlgorithmController algorithm;

  GraphTool tool = MoveTool();

  double lastScale = 1.0;
  Offset? lastFocalPoint;

  GraphController({
    required this.graph,
    required this.camera,
    required this.selection,
    required this.tools,
    required this.algorithm}) {
    _generate();
  }

  void _generate() {
    graph.nodes.add(NodeModel(index: graph.nodes.length, position: Offset(0, 0)));
  }

  NodeModel? nodeAt(Offset position) {
    for (NodeModel node in graph.nodes) {
      double dx = position.dx - node.position.dx;
      double dy = position.dy - node.position.dy;

      if (dx * dx + dy * dy <= camera.nodeRadius * camera.nodeRadius) {
        return node;
      }
    }

    return null;
  }

  bool handleSelection(Offset position) {
    NodeModel? node = nodeAt(position);

    if (node != null) {
      selection.select(node);
      selection.bNodeGrabbed = false;
      return true;
    }

    return false;
  }

  void handleGrab(Offset position) {
    if (handleSelection(position)) {
      selection.bNodeGrabbed = true;
    }
  }

  void handleTapDown(TapDownDetails details) {
    tool.onTapDown(this, camera.toWorldCoordinates(details.localPosition));
  }

  void handleScaleStart(ScaleStartDetails details) {
    tool.onScaleStart(this, details);
  }

  void handleScaleUpdate(ScaleUpdateDetails details) {
    tool.onScaleUpdate(this, details);
  }

  void handleScaleEnd(ScaleEndDetails details) {
    tool.onScaleEnd(this, details);
  }
}