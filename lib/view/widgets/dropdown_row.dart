import 'package:flutter/material.dart';

class DropdownRow extends StatelessWidget {
  final String label;
  final String value;
  final Map currencies;
  final void Function(String?) onChanged;

  const DropdownRow({
    required this.label,
    required this.value,
    required this.currencies,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(width: 20,),
        Expanded(
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(15),
            menuMaxHeight: 500.0,
            value: value,
            icon: const Icon(Icons.arrow_drop_down_rounded),
            isExpanded: true,
            onChanged: onChanged,
            items: currencies.keys.toSet().toList()
                .map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text('$value - ${currencies[value]}',
                overflow: TextOverflow.ellipsis,),
              );
            }).toList(),
          ),
        ),
        const SizedBox(width: 20,),
      ],
    );
  }
}

