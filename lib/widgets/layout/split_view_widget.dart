import 'package:flutter/material.dart';

class SplitViewWidget extends StatefulWidget {
  final Widget first;
  final Widget second;

  final double initialRatio;
  final double minRatio;
  final double maxRatio;

  final bool vertical;

  const SplitViewWidget({
    required this.first,
    required this.second,
    this.initialRatio = 0.5,
    this.minRatio = 0.1,
    this.maxRatio = 0.9,
    this.vertical = false,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _SplitViewWidgetState();
}

class _SplitViewWidgetState extends State<SplitViewWidget> {
  late double ratio = widget.initialRatio;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final children = [
          SizedBox(
            width: !widget.vertical? constraints.maxWidth * ratio : null, 
            height: widget.vertical? constraints.maxHeight * ratio : null,
            child: widget.first
          ),
          GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (!widget.vertical) _onDrag(details, constraints.maxWidth);
            },
            onVerticalDragUpdate: (details) {
              if (widget.vertical) _onDrag(details, constraints.maxHeight);
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Container(
                width: widget.vertical ? double.infinity : 6,
                height: widget.vertical ? 6 : double.infinity,
                color: scheme.outlineVariant,
              ),
            )
          ),
          Expanded(child: widget.second)
        ];

        return widget.vertical?
          Column(children: children)
          : Row(children: children);
      }
    );
  }

  void _onDrag(DragUpdateDetails details, double maxSize) {
    setState(() {
      if (widget.vertical) {
        ratio = ratio + (details.delta.dy / maxSize);
      } else {
        ratio = ratio + (details.delta.dx / maxSize);
      }
      ratio = ratio.clamp(widget.minRatio, widget.maxRatio);
    });
  }
}