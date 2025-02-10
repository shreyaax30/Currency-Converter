import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/currency_list.dart';
import '../models/exchange_rate_data.dart';
import '../widgets/currency_dropdown.dart';
import '../widgets/convert_button.dart';
import '../widgets/swap_button.dart';
import '../widgets/exchange_graph.dart'; 

//using Frankfureter API
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  double? convertedAmount;
  double? toBeConvertedAmount;
   double? exchangeRate;
  bool showResult = false;
  TextEditingController amountController = TextEditingController();


  List<ExchangeRateData> historicalRatesList = [];

  String selectedSource = "USD - United States Dollar";
  String selectedDestination = "INR - Indian Rupee";
  String? base;
  String? target;



//return the first word i.e. currency code - api need currency code not the whole name
  String getCurrencyCode(String fullName) {
    return fullName.split(" - ")[0]; // Extracts "USD" from "USD - United States Dollar"
  }

//convert currency when convert button clicked!
 Future<void> convertCurrency() async{
    setState(() {
      toBeConvertedAmount = double.tryParse(amountController.text);
    });

    try {
       base = getCurrencyCode(selectedSource);
       target = getCurrencyCode(selectedDestination);

      // Fetch Current Exchange Rate
      exchangeRate = await ApiService.fetchCurrentRate(base, target);

      // Fetch Historical Exchange Data
      historicalRatesList = await ApiService.fetchHistoricalData(base, target);

      setState(() {
        convertedAmount = toBeConvertedAmount! * exchangeRate!;
        showResult = true;
      });
    } catch (e) {
      debugPrint("Error fetching exchange rate: $e");
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      appBar: AppBar(
        title: Text('Currency Converter'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),

      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
        margin: const EdgeInsets.all(9),
        color: Theme.of(context).colorScheme.primary,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //enter amount
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Enter Amount',
                      labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
          
                      enabledBorder: UnderlineInputBorder( // Normal state
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.onSecondary),
                     ),
                      focusedBorder: UnderlineInputBorder( // When user starts typing
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.onSecondary, width: 2.0),
                     ),
                    ),
                  ),
                ),
          
                //from DropDown
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'From :   ',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0,
                        color: Theme.of(context).colorScheme.onSecondary ,
                      ),
                    ),
          
                    //choose currency to convert
                    CurrencyDropdown(
                      selectedCurrency: selectedSource,
                       currencies: currencies,
                       onChanged: (value) => setState(() =>
                          selectedSource = value!
                        ),
                      ),
                  ],
                ),
                 
                //Swap Button
                Center(
                  child: SwapButton(onSwap: (){
                    setState(() {
                      String temp = selectedSource;
                      selectedSource = selectedDestination;
                      selectedDestination = temp;
                    });
                  })
                ),
          

                //to DropDown
                Row(
                  children: [
                    Text(
                      'To :      ',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0,
                        color: Theme.of(context).colorScheme.onSecondary ,
                      ),
                    ),
          
                    //select currency to convert into
                   CurrencyDropdown(
                    selectedCurrency: selectedDestination,
                     currencies: currencies,
                     onChanged: (value) => setState(() =>
                      selectedDestination = value! 
                     ),
                   ),
                  ],
                ),


               SizedBox(height: 20),

                //convert button
                Center(
                  child: ConvertButton(onConvert: convertCurrency),
                 ),

                SizedBox(height: 30),
              
              //display result 
                if (showResult) ...[
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Converted Amount: ${currencySymbols[target]}${convertedAmount?.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
          
                        SizedBox(height: 5),
          
                        Text(
                          'Exchange Rate: 1 ${getCurrencyCode(selectedSource)} = ${exchangeRate?.toStringAsFixed(2)} ${getCurrencyCode(selectedDestination)}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
          
                        SizedBox(height: 130),
          
                        //graph
                        ExchangeGraph(historicalRatesList: historicalRatesList),
                    ],
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}                       


