import 'package:flutter/material.dart';

class CurrencyDropdown extends StatelessWidget{

final String selectedCurrency;
final List currencies;
final ValueChanged<String?> onChanged;


  const CurrencyDropdown({
    required this.selectedCurrency,
    required this.currencies,
    required this.onChanged,
    super.key,
  });
  
 @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      dropdownColor: Theme.of(context).colorScheme.secondary,
      value: selectedCurrency,
      items: currencies.map((currency) {
        return DropdownMenuItem<String>(
          value: currency,
          child: Text(currency),
        );
      }).toList(),
      onChanged: onChanged,
      style: TextStyle(fontSize: 17.0, color: Theme.of(context).colorScheme.onSecondary),
    );
  }
}