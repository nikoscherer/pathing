import 'package:flutter/material.dart';
import 'package:pathing/models/node_model.dart';

class NodeWidget extends StatelessWidget {
  final NodeModel node;
  final double size;
  const NodeWidget({required this.node, required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(node.location.dx, node.location.dy),
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}