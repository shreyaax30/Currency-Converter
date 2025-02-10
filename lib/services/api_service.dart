//import http package - allows to make HTTP requests
import 'package:http/http.dart' as http;
//dart:convert for decoding JSON
import 'dart:convert';
import 'package:intl/intl.dart';
import '../models/exchange_rate_data.dart';

//using Frankfurter API (does not require api key)
class ApiService {

  //function to fetch exchange rate
  
  static Future<double> fetchCurrentRate(String? base, String? target) async {

    final url = Uri.parse(
        'https://api.frankfurter.dev/v1/latest?base=$base&symbols=$target'
       );

    print("Fetching live exchange rate from: $url");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['rates'][target];
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
        throw Exception("Error: $e");
    }
  }


  //to fetch historical data - last 6 months
  static Future<List<ExchangeRateData>> fetchHistoricalData(String? base, String? target) async {
    DateTime today = DateTime.now();
    String todayDate =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

    DateTime sixMonthsAgo = today.subtract(Duration(days: 180));
    String sixMonthsAgoDate =
        "${sixMonthsAgo.year}-${sixMonthsAgo.month.toString().padLeft(2, '0')}-${sixMonthsAgo.day.toString().padLeft(2, '0')}";

    final url = Uri.parse(
        'https://api.frankfurter.dev/v1/$sixMonthsAgoDate..$todayDate?base=$base&symbols=$target');


    try {
      final response = await http.get(url);


      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);

        List<ExchangeRateData> historicalRates = [];

        data["rates"].forEach((date, value) {

          double rate = value[target]; //// Extract exchange rate for the target currency

          //date is originally a string, DateTime.parse(date) converts it into a DateTime object
          DateTime parsedDate = DateTime.parse(date);

          //DateFormat('MMM') is from the intl package
          //MMM returns short month names - jan, feb
          String monthName = DateFormat('MMM')
              .format(parsedDate); // Convert date to month name (e.g., "Jan")

          //Stores the extracted exchange rate and month name
          historicalRates.add(ExchangeRateData(parsedDate, rate, monthName));
        });

        return historicalRates;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}