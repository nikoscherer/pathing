import 'package:flutter/material.dart';

class CameraController extends ChangeNotifier {
  double zoom = 1.0;
  final double minZoom = 0.25;
  final double maxZoom = 5;

  double gridSpacing = 50;
  double nodeRadius = 50;

  Offset pan = Offset.zero;
  Size size = Size.zero;

  void updateZoom(double newZoom, Offset newPan) {
    zoom = newZoom.clamp(minZoom, maxZoom);
    pan = newPan;
    notifyListeners();
  }

  Offset toWorldCoordinates(Offset screenCoordinate) {
    return screenCoordinate
      .translate(-size.width / 2, -size.height / 2)
      .scale( 1/ zoom, -1 / zoom)
      .translate(pan.dx, pan.dy);
  }  
}