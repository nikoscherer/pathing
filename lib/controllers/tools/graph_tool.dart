import 'package:flutter/material.dart';
import 'package:pathing/controllers/graph_controller.dart';
import 'package:pathing/models/node_model.dart';

abstract class GraphTool {
  void onTapDown(GraphController controller, Offset worldPosition) {}

  void onScaleStart(GraphController controller, ScaleStartDetails details) {
    controller.lastScale = 1.0;
    controller.lastFocalPoint = details.focalPoint;
    controller.handleSelection(controller.camera.toWorldCoordinates(details.localFocalPoint));
  }

  void onScaleUpdate(GraphController controller, ScaleUpdateDetails details) {
    if (!controller.selection.bNodeGrabbed) {
      double zoom = controller.camera.zoom * details.scale / controller.lastScale;
      Offset pan = controller.camera.pan +
       (zoom - controller.camera.zoom == 0? details.focalPointDelta.scale(-1, 1) : Offset(0, 0))
        / controller.camera.zoom;
      controller.camera.updateZoom(zoom, pan);

      controller.lastScale = details.scale;
      controller.lastFocalPoint = details.focalPoint;
    }
  }

  void onScaleEnd(GraphController controller, ScaleEndDetails details) {
    controller.lastScale = 1.0;
    controller.lastFocalPoint = null;
    controller.selection.bNodeGrabbed = false;
  }
}

enum MoveGestureMode {
  undecided,
  dragNode,
  zoomPan
}

class MoveTool extends GraphTool {
  MoveGestureMode mode = MoveGestureMode.undecided;

  @override
  void onTapDown(GraphController controller, Offset worldPosition) {
    controller.handleSelection(worldPosition);
  }

  @override
  void onScaleStart(GraphController controller, ScaleStartDetails details) {
    controller.lastScale = 1.0;
    controller.lastFocalPoint = details.focalPoint;
    controller.handleSelection(controller.camera.toWorldCoordinates(details.localFocalPoint));
    mode = MoveGestureMode.undecided;
  }

  @override
  void onScaleUpdate(GraphController controller, ScaleUpdateDetails details) {
    if (controller.selection.hasNode() && details.pointerCount == 1) {
      Offset position = controller.camera.toWorldCoordinates(details.localFocalPoint);
      controller.graph.moveNode(controller.selection.selectedNode!, position);
      debugPrint("Moving node: $position");
    } else {
      double zoom = controller.camera.zoom * details.scale / controller.lastScale;
      Offset pan = controller.camera.pan +
       (zoom - controller.camera.zoom == 0? details.focalPointDelta.scale(-1, 1) : Offset(0, 0))
        / controller.camera.zoom;
      controller.camera.updateZoom(zoom, pan);

      controller.lastScale = details.scale;
      controller.lastFocalPoint = details.focalPoint;
    }
  }

  @override
  void onScaleEnd(GraphController controller, ScaleEndDetails details) {
    controller.lastScale = 1.0;
    controller.lastFocalPoint = null;
    controller.selection.bNodeGrabbed = false;
    mode = MoveGestureMode.undecided;
  }
}

class ConnectTool extends GraphTool {
  Offset? lastScalePosition;

  @override
  void onTapDown(GraphController controller, Offset worldPosition) {
    controller.handleSelection(worldPosition);
  }

  @override
  void onScaleStart(GraphController controller, ScaleStartDetails details) {
    NodeModel? node = controller.nodeAt(controller.camera.toWorldCoordinates(details.localFocalPoint));

    if (node != null) {
      controller.selection.startConnection(node);
    }
  }

  @override
  void onScaleUpdate(GraphController controller, ScaleUpdateDetails details) {
    if (controller.selection.connectionStart == null) return;

    controller.selection.updateConnection(controller.camera.toWorldCoordinates(details.localFocalPoint));
    lastScalePosition = details.localFocalPoint;
  }

  @override
  void onScaleEnd(GraphController controller, ScaleEndDetails details) {
    if (controller.selection.connectionStart != null) {
      NodeModel startNode = controller.selection.connectionStart!;
      NodeModel? connectionNode = controller.nodeAt(controller.camera.toWorldCoordinates(lastScalePosition!));

      if (connectionNode != null) {
        if (!startNode.neighbors.contains(connectionNode)) {
          controller.graph.connect(controller.selection.connectionStart!, connectionNode);
        } else {
          controller.graph.disconnect(controller.selection.connectionStart!, connectionNode);
        }
      }
    }

    controller.selection.endConnection();
    lastScalePosition = null;
  }
}

class AddTool extends GraphTool {
  @override
  void onTapDown(GraphController controller, Offset worldPosition) {
    Offset position = controller.camera.pan *  (1 / controller.camera.zoom) + worldPosition;
    controller.graph.addNode(position);
    debugPrint("Added Node at: ${position.toString()}");
  }

  @override
  void onScaleStart(GraphController controller, ScaleStartDetails details) {
    
  }

  @override
  void onScaleUpdate(GraphController controller, ScaleUpdateDetails details) {
    
  }

  @override
  void onScaleEnd(GraphController controller, ScaleEndDetails details) {

  }
}