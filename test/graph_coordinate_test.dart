import 'package:flutter_test/flutter_test.dart';
import 'package:pathing/widgets/graph/notifiers/graph_controller.dart';

void main() {
  test('Conversion Testing', () {
    GraphController controller = GraphController();

    Offset offset = Offset(0, 0);
    controller.canvasWidth = 600;
    controller.canvasHeight = 600;

    expect(Offset(300, 300), controller.worldToCanvas(offset));
    expect(offset, controller.canvasToWorld(Offset(300, 300)));
  });

  test('Zoom Testing', () {
    
  });
}