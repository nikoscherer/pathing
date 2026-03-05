import 'package:pathing/models/node_model.dart';

class GraphBuilder {
  static List<NodeModel> build(int width, int height) {
    final nodes = <NodeModel>[];

    int index = 0;

    for (int row = 0; row < height; row++) {
      for (int col = 0; col < width; col++) {
        final node = NodeModel(index: index);

        if (col > 0) {
          final left = nodes[index - 1];
          node.connect(left, Direction.left);
        }

        if (row > 0) {
          final up = nodes[index - width];
          node.connect(up, Direction.up);
        }

        nodes.add(node);
        index++;
      }
    }

    return nodes;
  }
}