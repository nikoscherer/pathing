import 'package:flutter/material.dart';
import 'package:pathing/models/node_model.dart';
import 'package:pathing/widgets/algorithms/algorithm_dropdown.dart';
import 'package:pathing/widgets/graph/graph_controller.dart';

class ControlPanel extends StatelessWidget {
  final GraphController controller;

  const ControlPanel({
    required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller, 
      builder: (context, _) {
        return Column(
          spacing: 15.0,
          crossAxisAlignment: .center,
          mainAxisAlignment: .start,
          children: [
            Column(
              crossAxisAlignment: .center,
              mainAxisAlignment: .start,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Container(
                    color: controller.drawType.color,
                  )
                ),
                Text(controller.drawType.name)
              ]
            ),
            Spacer(flex: 1),
            SizedBox(
              width: 140,
              height: 40,
              child: FloatingActionButton.extended(
              onPressed: () => controller.setDrawType(DrawType.start), 
              label: Text("Set Start Node"))
            ),
            SizedBox(
              width: 140,
              height: 40,
              child: FloatingActionButton.extended(
                onPressed: () => controller.setDrawType(DrawType.target),
                label: Text("Set Target Node")
              )
            ),
            SizedBox(
              width: 140,
              height: 40,
              child: AlgorithmDropdown(
                setAlgorithmType: controller.setAlgorithmType, 
                width: 140
              ),
            ),
            Spacer(flex: 1),
            Row(
              spacing: 10.0,
              children: [
                FloatingActionButton(
                  onPressed: controller.run,
                  child: Icon(Icons.play_arrow),
                ),
                FloatingActionButton(
                  onPressed: controller.pause,
                  child: Icon(Icons.pause),
                ),
              ],
            ),
            Row(
              spacing: 10.0,
              children: [
                FloatingActionButton(
                  onPressed: controller.step,
                  child: Icon(Icons.skip_next),
                ),
                FloatingActionButton(
                  onPressed: controller.restart,
                  child: Icon(Icons.replay),
                ),
              ],
            ),
            Column(
              children: [
                Text("Speed: ${controller.speed.toStringAsFixed(2)}x"),
                Slider(
                  min: 0.25,
                  max: 2.0,
                  divisions: 7,
                  value: controller.speed,
                  onChanged: (value) {
                    controller.setSpeed(value);
                  },
                ),
              ],
            ),
            Spacer(flex: 2)
          ],
        );
      }
    );
  }
}