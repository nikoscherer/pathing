import 'package:flutter/material.dart';
import 'package:pathing/models/node_model.dart';

class Node extends StatefulWidget {
  final NodeModel model;

  final void Function(int index) onTap;

  const Node({required this.model, required this.onTap, super.key});

  @override
  State<StatefulWidget> createState() => _NodeState();
}

class _NodeState extends State<Node> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.model.getColor(),
      child: GestureDetector(
        onTap: () => {
          setState(() {
            widget.onTap(widget.model.index);
          })
        },
      ),
    );
  }
}