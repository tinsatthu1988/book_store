import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? color;

  Badge({required this.child, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          left: 8,
          child: Container(
            child: Text(value, textAlign: TextAlign.center, style: TextStyle(fontSize: 11),),
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: color),
            constraints: BoxConstraints(minHeight: 16, minWidth: 16),
          ),
        ),
      ],
    );
  }


}