import 'dart:ui';

enum Direction {
  left,
  right,
  up,
  down
}

enum DrawType {
  toggle("Toggle", Color.fromARGB(255, 120, 120, 120)),
  start("Start", Color.fromARGB(255, 0, 255, 0)),
  target("Target", Color.fromARGB(255, 255, 0, 0));

  final String name;
  final Color color;
  const DrawType(this.name, this.color);
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

  NodeModel? up;
  NodeModel? right;
  NodeModel? down;
  NodeModel? left;

  Offset location;

  List<NodeModel> neighbors = [];

  NodeModel({
      required this.index,
      this.type = NodeType.active,
      this.visited = false,
      this.up,
      this.right,
      this.down,
      this.left,
      this.location = const Offset(0, 0)
  });

  Color getColor() {
    if (visited && type != NodeType.start && type != NodeType.target) {
      return Color.fromARGB(255, 200, 200, 0);
    } else {
      return type.color;
    }
  }

  List<NodeModel> getNeighbors() {
    List<NodeModel> neighbors = [];
    if (up != null && up!.type != NodeType.inactive) {
      neighbors.add(up!);
    }
     if (right != null && right!.type != NodeType.inactive) {
      neighbors.add(right!);
    }
     if (down != null && down!.type != NodeType.inactive) {
      neighbors.add(down!);
    }
     if (left != null && left!.type != NodeType.inactive) {
      neighbors.add(left!);
    }

    return neighbors;
  }

  void draw(DrawType drawType) {
    switch (drawType) {
      case DrawType.toggle:
        if (type == NodeType.active) {
          type = NodeType.inactive;
        } else {
          type = NodeType.active;
        }
        return;
      case DrawType.start:
        type = NodeType.start;
        return;
      case DrawType.target:
        type = NodeType.target;
        return;
    }
  }

  void connect(NodeModel node, Direction direction) {
    switch (direction) {
      case Direction.left:
        left = node;
        node.right = this;
        return;
      
      case Direction.right:
        right = node;
        node.left = this;
        return;

      case Direction.down:
        down = node;
        node.up = this;
        return;

      case Direction.up:
        up = node;
        node.down = this;
        return;
    }
  }
}