import 'package:flutter/material.dart';
import 'package:pathing/controllers/graph_controller.dart';
import 'package:provider/provider.dart';

class EditorControlsWidget extends StatelessWidget {
  const EditorControlsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GraphController>();
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Row(
        spacing: 10,
        children: [
          FloatingActionButton(
            child: Icon(Icons.open_with),
            onPressed: () {
              
            }
          ),
          FloatingActionButton(
            child: Icon(Icons.device_hub),
            onPressed: () {
              
            }
          ),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              
            }
          ),
          
          
        ],
      )
    );
  }
}