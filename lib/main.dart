import 'package:flutter/material.dart';
import 'package:pathing/theme/theme.dart';
import 'package:pathing/widgets/algorithm_visualizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pathing Visualizer',
      theme: themeData,
      home: const PathingHomePage(title: 'Pathing Visualizer'),
    );
  }
}

class PathingHomePage extends StatefulWidget {
  final String title;

  const PathingHomePage({super.key, required this.title});

  @override
  State<PathingHomePage> createState() => _PathingHomePageState();
}

class _PathingHomePageState extends State<PathingHomePage> {
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
      body: AlgorithmVisualizer(),
    );
  }
}
