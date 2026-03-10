import 'package:flutter/material.dart';
import 'package:pathing/widgets/controls/controls_widget.dart';
import 'package:pathing/widgets/graph/graph_widget.dart';
import 'package:pathing/widgets/layout/split_view_widget.dart';

class AlgorithmVisualizer extends StatelessWidget {
  final bool reversed = false;
  const AlgorithmVisualizer({super.key});

  @override
  Widget build(BuildContext context) {
    return SplitViewWidget(
      first: !reversed? GraphWidget() : ControlsWidget(),
      second: !reversed? ControlsWidget() : GraphWidget(),
      initialRatio: 0.65,
      minRatio: 0.4,
      maxRatio: 0.65,
      vertical: false
    );
  }
}