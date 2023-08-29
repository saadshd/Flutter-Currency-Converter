import 'package:currency_convertor/Model/rates_model.dart';
import 'package:currency_convertor/View/Widgets/conversion_card.dart';
import 'package:currency_convertor/data/network/api_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<RatesModel> ratesModel;
  late Future<Map> currenciesModel;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    ratesModel = fetchRates();
    currenciesModel = fetchCurrencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const Icon(Icons.currency_exchange),
        title: const Text('Currency Convertor'),
      ),
      body: FutureBuilder<RatesModel>(
        future: ratesModel,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          } else {
            return FutureBuilder<Map>(
                future: currenciesModel,
                builder: (context, index){
                  if (index.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(),);
                  } else if (index.hasError) {
                    return Center(child: Text('Error: ${index.error}'));
                  } else {
                    return ConversionCard(
                      rates: snapshot.data!.rates,
                      currencies: index.data!,
                    );
                  }
                }
            );
          }
        }
      ),
    );
  }
}
