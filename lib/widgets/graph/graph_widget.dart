import 'package:flutter/material.dart';
import 'package:pathing/models/node_model.dart';
import 'package:pathing/widgets/graph/graph_painter.dart';
import 'package:pathing/widgets/graph/notifiers/graph_controller.dart';
import 'package:provider/provider.dart';

class GraphWidget extends StatefulWidget {
  final double initialNodeSize = 60;

  const GraphWidget({super.key});
  
  @override
  State<StatefulWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  late double nodeSize = widget.initialNodeSize;

  late double width;
  late double height;

  double lastScale = 1.0;
  Offset? lastFocalPoint;

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GraphController>();

    return SizedBox.expand(
      child: LayoutBuilder(
        builder: (context, constraints) {
            
          return GestureDetector(
            behavior: .opaque,
            onScaleStart: (details) {
              lastScale = 1.0;
              lastFocalPoint = details.focalPoint;
            },
            onScaleUpdate: (details) {
              double zoom = controller.zoom * details.scale / lastScale;
              Offset pan = controller.pan + (zoom - controller.zoom == 0? details.focalPointDelta : Offset(0, 0)) / controller.zoom;
              controller.updateZoom(zoom, pan);
              
              lastScale = details.scale;
              lastFocalPoint = details.focalPoint;
            },
            onScaleEnd: (_) {
              lastScale = 1.0;
              lastFocalPoint = null;
            },
            onDoubleTap: () {
              
            },
            onSecondaryTapDown: _onSecondaryTapDown,
            child:  CustomPaint(
              size: Size.infinite,
              painter: GraphPainter(
                controller: controller
              ),
            ),
          );
        },
      )
    );
  }

  void _onSecondaryTapDown(TapDownDetails details) {
    setState(() {
      debugPrint("Test");
      final controller = context.read<GraphController>();
      controller.nodes.add(NodeModel(index: controller.nodes.length, location: details.localPosition));
    });
  }
}