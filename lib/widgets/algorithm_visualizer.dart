import 'package:flutter/material.dart';
import 'package:pathing/widgets/layout/split_view_widget.dart';

class AlgorithmVisualizer extends StatelessWidget {
  const AlgorithmVisualizer({super.key});

  @override
  Widget build(BuildContext context) {
    return SplitViewWidget(
      first: Container(color: Color.fromARGB(255, 100, 100, 100), child: Text("First")), 
      second: Container(color: Color.fromARGB(255, 100, 100, 100), child: Text("Second")),
      initialRatio: 0.75,
      minRatio: 0.4,
      maxRatio: 0.65,
      vertical: false
    );
  }
}