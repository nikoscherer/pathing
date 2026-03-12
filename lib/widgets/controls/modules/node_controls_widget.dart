import 'package:flutter/material.dart';
import 'package:pathing/models/node_model.dart';
import 'package:pathing/controllers/graph_controller.dart';
import 'package:provider/provider.dart';

class NodeControlsWidget extends StatefulWidget {
  const NodeControlsWidget({super.key});
  
  @override
  State<StatefulWidget> createState() => _NodeControlsWidgetState();
}

class _NodeControlsWidgetState extends State<NodeControlsWidget> {
  final xController = TextEditingController();
  final yController = TextEditingController();

  bool updateX = true;
  bool updateY = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    xController.dispose();
    yController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GraphController>();
    final node = controller.selectedNode;

    if (node != null) {
      if (xController.text != node.location.dx.toString() && updateX) {
        xController.text = node.location.dx.toStringAsFixed(2);
      }

      if (yController.text != node.location.dy.toString() && updateY) {
        yController.text = node.location.dy.toStringAsFixed(2);
      }
    } else {
      xController.text = "";
      yController.text = "";
    }

    return Column(
      spacing: 10,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: xController,
                keyboardType: .number,
                onTap: () {
                  updateX = false;
                },
                onChanged: (value) {
                  setState(() {
                    if (node == null) return;
                    updateX = false;
                    final parsed = double.tryParse(value);
                    if (parsed != null) {
                      node.location = Offset(parsed, node.location.dy);
                    }
                  });
                },
                onSubmitted: (value) {
                  updateX = true;
                },
                onTapOutside: (event) {
                  updateX = true;
                },
                decoration: InputDecoration(
                  labelText: "X"
                ),
              )
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: yController,
                keyboardType: .number,
                onTap: () {
                  updateY = false;
                },
                onChanged: (value) {
                  if (node == null) return;
                  updateY = false;
                  final parsed = double.tryParse(value);
                  if (parsed != null) {
                    setState(() {
                      node.location = Offset(node.location.dx, parsed);
                    });
                  }
                },
                onSubmitted: (value) {
                  updateY = true;
                },
                onTapOutside: (event) {
                  updateY = true;
                },
                decoration: InputDecoration(
                  labelText: "Y"
                ),
              )
            ),
          ],
        ),
        Row(
          mainAxisAlignment: .start,
          spacing: 5,
          children: [
            SizedBox(
              width: 5,
              height: 40,
              child: Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: controller.selectedNode?.getColor() ?? Colors.transparent,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              )
            ),
            DropdownMenu<NodeType>(
              label: Text("Node Type"),
              key: ValueKey(controller.selectedNode),
              initialSelection: controller.selectedNode?.type,
              onSelected: (value) {
                if (controller.selectedNode == null) return;
                setState(() {
                  controller.selectedNode!.type = value!;
                });
              },
              dropdownMenuEntries: controller.selectedNode != null? const [
                DropdownMenuEntry(
                  value: NodeType.active,
                  label: "Active"
                ),
                DropdownMenuEntry(
                  value: NodeType.start,
                  label: "Start"
                ),
                DropdownMenuEntry(
                  value: NodeType.target,
                  label: "Target"
                ),
              ] : [],
            )
          ],
        )
      ],
    );
  }
}