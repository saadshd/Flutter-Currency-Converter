
class Utils {

  static String convert(
      Map exchangeRates,
      String amount,
      String currencyBase,
      String currencyFinal,
      ) {
    double usdAmount = double.parse(amount) / exchangeRates[currencyBase];
    String output =
    (usdAmount * exchangeRates[currencyFinal]).toStringAsFixed(2);
    return output;
  }

}