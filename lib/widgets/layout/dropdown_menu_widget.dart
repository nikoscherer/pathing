import 'package:flutter/material.dart';

class DropdownMenuWidget extends StatefulWidget {
  final String title;
  final Widget menu;
  final bool initializeExpanded;

  const DropdownMenuWidget({
    required this.title,
    required this.menu,
    this.initializeExpanded = false, 
    super.key});
  
  @override
  State<StatefulWidget> createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<DropdownMenuWidget> {
  late bool expanded = widget.initializeExpanded;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.fromLTRB(20, 15, 15, 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),

        color: scheme.surfaceContainer,
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                widget.title, 
                style: textTheme.titleMedium?.copyWith(color: scheme.onSurface)
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  setState(() {
                    expanded = !expanded;
                  });
                }, 
                icon: Icon(!expanded? Icons.arrow_drop_up : Icons.arrow_drop_down)
              )
            ],
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: expanded? widget.menu : const SizedBox.shrink()
          )
        ],
      )
    );
  }
}