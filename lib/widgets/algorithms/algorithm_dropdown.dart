import 'package:flutter/material.dart';

class AlgorithmDropdown extends StatefulWidget {
  final double? width;

  final void Function(AlgorithmType) setAlgorithmType;
  
  const AlgorithmDropdown({required this.setAlgorithmType, this.width, super.key});

  @override
  State<StatefulWidget> createState() => _AlgorithmDropdownState();
}

enum AlgorithmType {
  bfs,
  dfs
}

class _AlgorithmDropdownState extends State<AlgorithmDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      label: Text("Algorithm"),
      initialSelection: AlgorithmType.bfs,
      width: widget.width,
      onSelected: (newType) => {
        if (newType != null) {
          widget.setAlgorithmType(newType)
        }
      },
      dropdownMenuEntries: [
        DropdownMenuEntry(
          value: AlgorithmType.bfs,
          label: "BFS"
        ),
        DropdownMenuEntry(
          value: AlgorithmType.dfs,
          label: "DFS"
        )
      ],
    );
  }
}