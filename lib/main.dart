import 'package:flutter/material.dart';
import 'package:pathing/controllers/algorithm_controller.dart';
import 'package:pathing/controllers/camera_controller.dart';
import 'package:pathing/controllers/graph_model.dart';
import 'package:pathing/controllers/selection_controller.dart';
import 'package:pathing/controllers/tool_controller.dart';
import 'package:pathing/theme/app_theme.dart';
import 'package:pathing/widgets/algorithm_visualizer.dart';
import 'package:pathing/controllers/graph_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GraphModel()),
        ChangeNotifierProvider(create: (_) => CameraController()),
        ChangeNotifierProvider(create: (_) => SelectionController()),
        ChangeNotifierProvider(create: (_) => ToolController()),

        ChangeNotifierProvider(create: (_) => AlgorithmController()),

        Provider(
          create: (context) => GraphController(
            graph: context.read<GraphModel>(),
            camera: context.read<CameraController>(),
            selection: context.read<SelectionController>(),
            tools: context.read<ToolController>(),
            algorithm: context.read<AlgorithmController>()
          ),
        )
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pathing Visualizer',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
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
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      backgroundColor: scheme.surfaceContainerLowest,
      body: AlgorithmVisualizer(),
    );
  }
}
