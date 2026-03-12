import 'package:flutter/material.dart';

class GraphModel extends ChangeNotifier {
  double zoom = 1.0;
  final double minZoom = 0.25;
  final double maxZoom = 5;

  Offset pan = Offset.zero;
}