import 'package:flutter/material.dart';

class SwapButton extends StatelessWidget {
  final VoidCallback onSwap;

  const SwapButton({required this.onSwap, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.tertiary,
      ),
      child: IconButton(
        onPressed: onSwap,
        icon: Icon(Icons.swap_vert, size: 25.0),
      ),
    );
  }
}


