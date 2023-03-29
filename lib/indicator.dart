import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
final bool isActive;
const Indicator({Key? key, required this.isActive}) : super(key: key);

@override
Widget build(BuildContext context) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 350),
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    width: isActive ? 20.0:10.0,
    height: 8.0,
    decoration: BoxDecoration(
      color: isActive ? Colors.green.shade900:Colors.grey,
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
}
}