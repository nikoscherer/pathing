import 'package:flutter/material.dart';
import 'package:pathing/algorithms/algorithm.dart';

class AlgorithmControlsWidget extends StatelessWidget {
  const AlgorithmControlsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        DropdownMenu<AlgorithmType>(
          expandedInsets: EdgeInsets.symmetric(horizontal: 40.0),
          label: const Text("Algorithm"),
          textStyle: Theme.of(context).textTheme.bodyMedium,
          dropdownMenuEntries: AlgorithmType.values.map(
            (algo) => DropdownMenuEntry(
              value: algo, 
              label: algo.type
            )
          ).toList()
        )
      ],
    );
  }
}