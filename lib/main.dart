import 'package:flutter/material.dart';
import 'package:pathing/models/node_model.dart';
import 'package:pathing/theme/theme.dart';
import 'package:pathing/widgets/control_panel.dart';
import 'package:pathing/widgets/graph/graph_controller.dart';
import 'package:pathing/widgets/graph/node_graph.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeData,
      home: const MyHomePage(title: 'Pathing Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = GraphController();

  DrawType drawType = DrawType.start;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SizedBox.expand(
        child: Row(
          crossAxisAlignment: .center,
          children: [
            Container(
              padding: EdgeInsets.all(40.0),
              child: ControlPanel(controller: controller),
            ),
            VerticalDivider(
              width: 1,
            ),
            Expanded(
              child: Center(
                child: NodeGraph(
                  controller: controller
                ),
              ),
            )
          ]
        )
      )
    );
  }
}
