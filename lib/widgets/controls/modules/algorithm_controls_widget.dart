import 'package:flutter/material.dart';
import 'package:pathing/algorithms/algorithm.dart';
import 'package:pathing/controllers/algorithm_controller.dart';
import 'package:pathing/controllers/graph_model.dart';
import 'package:provider/provider.dart';

class AlgorithmControlsWidget extends StatelessWidget {
  const AlgorithmControlsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final algorithm = context.read<AlgorithmController>();
    final graph = context.read<GraphModel>();

    return Column(
      spacing: 10,
      mainAxisAlignment: .center,
      children: [
        DropdownMenu<AlgorithmType>(
          expandedInsets: EdgeInsets.symmetric(horizontal: 40.0),
          label: const Text("Algorithm"),
          textStyle: Theme.of(context).textTheme.bodyMedium,
          initialSelection: AlgorithmType.bfs,
          dropdownMenuEntries: AlgorithmType.values.map(
            (algo) => DropdownMenuEntry(
              value: algorithm.type,
              label: algo.type
            )
          ).toList(),
          onSelected: (value) {
            algorithm.type = value!;
            algorithm.initialize();
          },
        ),
        Row(
          mainAxisAlignment: .center,
          spacing: 10,
          children: [
            FloatingActionButton(
              onPressed: () {
                if (algorithm.algorithm == null) {
                  algorithm.initialize();
                }
                algorithm.play();
              },
              child: Icon(Icons.play_arrow),
            ),
            FloatingActionButton(
              onPressed: () {
                if (algorithm.algorithm == null) {
                  algorithm.initialize();
                }
                algorithm.step();
              },
              child: Icon(Icons.pause)
            ),
            FloatingActionButton(
              onPressed: () {
                if (algorithm.algorithm == null) {
                  algorithm.initialize();
                }
                algorithm.restart();
              },
              child: Icon(Icons.replay)
            ),
          ],
        )
      ],
    );
  }
}