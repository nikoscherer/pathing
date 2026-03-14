import 'dart:ui';

enum Direction {
  left,
  right,
  up,
  down
}

enum DrawType {
  move("Move Nodes"),
  connect("Connect Nodes"),
  add("Add Nodes");

  final String name;
  const DrawType(this.name);
}

enum NodeType {
  active(Color.fromARGB(255, 120, 120, 120)),
  inactive(Color.fromRGBO(0, 0, 0, 0)),
  start(Color.fromARGB(255, 0, 255, 0)),
  target(Color.fromARGB(255, 255, 0, 0));

  final Color color;
  const NodeType(this.color);
}

class NodeModel {
  NodeType type;

  final int index;

  bool visited;

  Offset position;

  List<NodeModel> neighbors = [];

  NodeModel({
      required this.index,
      this.type = NodeType.active,
      this.visited = false,
      this.position = const Offset(0, 0)
  });

  Color getColor() {
    if (visited && type != NodeType.start && type != NodeType.target) {
      return Color.fromARGB(255, 200, 200, 0);
    } else {
      return type.color;
    }
  }

  List<NodeModel> getNeighbors() {
    return neighbors;
  }

  void connect(NodeModel node) {
    neighbors.add(node);
    node.neighbors.add(this);
  }

  void disconnect(NodeModel node) {
    neighbors.remove(node);
    node.neighbors.remove(this);
  }
}