
import 'package:flutter/material.dart';
import 'package:pathing/widgets/graph/graph_controller.dart';
import 'package:pathing/widgets/graph/node.dart';

class NodeGraph extends StatelessWidget {
  final GraphController controller;

  const NodeGraph({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller, 
      builder: (context, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SizedBox(
              width: constraints.maxHeight * 0.9,
              height: constraints.maxHeight * 0.9,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: controller.width,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                  childAspectRatio: 1.0
                ),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.width * controller.height,
                itemBuilder: (context, index) {
                  return Node(
                    model: controller.nodes[index],
                    onTap: (index) => controller.handleTap(index)
                  );
                }
              )
            );
          },
        );
      }
    );
  }
}