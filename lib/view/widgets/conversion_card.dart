import 'package:currency_convertor/View/Widgets/dropdown_row.dart';
import 'package:currency_convertor/utils/utils.dart';
import 'package:flutter/material.dart';

class ConversionCard extends StatefulWidget {
  final rates;
  final Map currencies;
  const ConversionCard({super.key, @required this.rates, required this.currencies});

  @override
  State<ConversionCard> createState() => _ConversionCardState();
}

class _ConversionCardState extends State<ConversionCard> {
  TextEditingController amountController = TextEditingController();
  final GlobalKey<FormFieldState> formFieldKey = GlobalKey();
  String dropdownValue1 = 'USD';
  String dropdownValue2 = 'PKR';
  String conversion = '';
  bool isLoading = false;

  void startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  void convertAndDisplay() {
    conversion =
    '${amountController.text} $dropdownValue1 = ${Utils.convert(widget.rates, amountController.text, dropdownValue1, dropdownValue2)} $dropdownValue2';
    stopLoading();
  }

  void swapCurrencies() {
    setState(() {
      String temp = dropdownValue1;
      dropdownValue1 = dropdownValue2;
      dropdownValue2 = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextFormField(
            key: formFieldKey,
            controller: amountController,
            decoration: const InputDecoration(
              hintText: 'Enter Amount',
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter an amount';
              }
              return null;
            },
          ),
          const SizedBox(height: 20,),
          DropdownRow(
            label: 'From:',
            value: dropdownValue1,
            currencies: widget.currencies,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue1 = newValue!;
              });
            },
          ),
          IconButton.filledTonal(
            icon: const Icon(Icons.swap_vert),
            onPressed: () {
              if(amountController.text.isEmpty){
                swapCurrencies();
              } else {
                swapCurrencies();
                convertAndDisplay();
              }
            },
          ),
          DropdownRow(
            label: 'To:',
            value: dropdownValue2,
            currencies: widget.currencies,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue2 = newValue!;
              });
            },
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (formFieldKey.currentState!.validate()) {
                      startLoading();
                      conversion = '';
                      convertAndDisplay();
                    }
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Convert'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Text(
            conversion,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          const Text('Currency Rates by Open Exchange Rates'),
        ],
      ),
    );
  }
}

