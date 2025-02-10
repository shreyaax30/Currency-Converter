import 'package:flutter/material.dart';

class ConvertButton extends StatelessWidget {
  final VoidCallback onConvert;

  const ConvertButton({required this.onConvert, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onConvert,

      style: ButtonStyle(
         padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
         backgroundColor: WidgetStatePropertyAll(
         Theme.of(context).colorScheme.tertiary),
        fixedSize: WidgetStatePropertyAll(Size(330, 40)),
      ),

      child: Text(
        "Convert",
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        
        
    );
  }
}
