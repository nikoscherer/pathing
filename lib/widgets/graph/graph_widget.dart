import 'package:flutter/material.dart';
import 'package:pathing/models/node_model.dart';
import 'package:pathing/widgets/graph/graph_painter.dart';
import 'package:pathing/controllers/graph_controller.dart';
import 'package:provider/provider.dart';

class GraphWidget extends StatefulWidget {

  const GraphWidget({super.key});
  
  @override
  State<StatefulWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  late double width;
  late double height;

  double lastScale = 1.0;
  Offset? lastFocalPoint;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GraphController>();

    return SizedBox.expand(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("(${controller.pan.dx.round()}, ${controller.pan.dy.round()})")
            )
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              controller.size = Size(constraints.maxWidth, constraints.maxHeight);
              
              return GestureDetector(
                behavior: .opaque,
                onScaleStart: (details) {
                  lastScale = 1.0;
                  lastFocalPoint = details.focalPoint;

                  controller.handleScaleStart(details);
                },
                onScaleUpdate: (details) {
                  switch (controller.drawType) {
                    case .move:
                      if (controller.selectedNode != null && controller.grabbedNode == true) {
                        controller.moveNode(controller.toWorldCoordinates(details.localFocalPoint));
                      } else {
                        double zoom = controller.zoom * details.scale / lastScale;
                        Offset pan = controller.pan + (zoom - controller.zoom == 0? details.focalPointDelta.scale(-1, 1) : Offset(0, 0)) / controller.zoom;
                        controller.updateZoom(zoom, pan);
                        
                        lastScale = details.scale;
                        lastFocalPoint = details.focalPoint;
                      }
                      break;
                    case .connect:

                      break;
                    case .add:

                      break;
                  }
                },
                onTapDown: (details) {
                  controller.selectNode(controller.toWorldCoordinates(details.localPosition));
                },
                onScaleEnd: (_) {
                  lastScale = 1.0;
                  lastFocalPoint = null;

                  controller.dropNode();
                },
                onSecondaryTapDown: _onSecondaryTapDown,
                child: CustomPaint(
                  size: Size.infinite,
                  painter: GraphPainter(
                    controller: controller
                  ),
                ),
              );
            },
          )
        ],
      )
    );
  }

  void _onSecondaryTapDown(TapDownDetails details) {
    setState(() {
      final controller = context.read<GraphController>();
      Offset location = controller.pan + controller.toWorldCoordinates(details.localPosition);
      debugPrint(location.toString());
      controller.nodes.add(NodeModel(index: controller.nodes.length, location: location));
    });
  }
}