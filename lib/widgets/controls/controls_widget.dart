import 'package:flutter/material.dart';
import 'package:pathing/widgets/controls/modules/algorithm_controls_widget.dart';
import 'package:pathing/widgets/layout/dropdown_menu_widget.dart';

class ControlsWidget extends StatelessWidget {
  const ControlsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),

            color: scheme.surfaceContainerLow
          ),
          child: Column(
            spacing: 10.0,
            children: [
              DropdownMenuWidget(
                title: "Algorithm", 
                menu: AlgorithmControlsWidget()
              ),
              DropdownMenuWidget(
                title: "Graph",
                menu: Container()
              )
            ],
          )
        ),
      )
    );
  }
}