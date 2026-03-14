import 'package:flutter/material.dart';
import 'package:pathing/controllers/camera_controller.dart';
import 'package:pathing/controllers/graph_model.dart';
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

  @override
  Widget build(BuildContext context) {
    final controller = context.read<GraphController>();
    context.watch<GraphModel>();
    final camera = context.watch<CameraController>();

    return SizedBox.expand(
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text("(${camera.pan.dx.round()}, ${camera.pan.dy.round()})")
            )
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              camera.size = Size(constraints.maxWidth, constraints.maxHeight);
              
              return GestureDetector(
                behavior: .opaque,
                onScaleStart: (details) => controller.handleScaleStart(details),
                onScaleUpdate: (details) => controller.handleScaleUpdate(details),
                onTapDown: (details) => controller.handleTapDown(details),
                onScaleEnd: (details) => controller.handleScaleEnd(details),
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
}