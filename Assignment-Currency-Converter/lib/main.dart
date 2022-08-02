/*
Name: Muhammad Umer
Roll No.: 19-NTU-CS-1157
Degree and Semester: BSIT-6th
*/

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.light().copyWith(
      dividerColor: const Color(0xFF113D6B),
      dataTableTheme: const DataTableThemeData(
        headingRowHeight: 45,
        dataRowHeight: 40,
        headingTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w800,
          fontFamily: "Nunito Sans",
          color: Color(0xFF113D6B),
        ),
        dataTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: "Nunito Sans",
          color: Color(0xFF4264A8),
        ),
      ),
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: const TextTheme(
        bodyText1: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: "Nunito Sans",
          color: Color(0xFF113D6B),
        ),
        bodyText2: TextStyle(
          fontSize: 17.5,
          fontWeight: FontWeight.bold,
          fontFamily: "Nunito Sans",
          color: Color(0xFF4264A8),
        ),
        headline1: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: "Nunito Sans",
          color: Color(0xFFFFFFFF),
        ),
        headline2: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: "Nunito Sans",
          color: Color(0xFFFFFFFF),
        ),
      ),
    ),
    home: SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xff055590), Color(0xff0a2542)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: const Scaffold(
          body: SingleChildScrollView(child: CurrencyConversionApp()),
        ),
      ),
    ),
  ));
}

class CurrencyConversionApp extends StatelessWidget {
  const CurrencyConversionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Currency Converter £',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Converter',
            style: Theme.of(context).textTheme.headline2,
          ),
          const Converter(),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Exchange Rates',
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(
            height: 5,
          ),
          Center(child: ExchangeRateInfo("AED"))
        ],
      ),
    );
  }
}

String from = "AED";
String to = "AED";
final items = [
  'AED',
  'CNY',
  'GBP',
  'PKR',
  'SAR',
  'USD',
];

class Converter extends StatefulWidget {
  const Converter({Key? key}) : super(key: key);

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  String amount = '0';
  String dropDownValueTo = 'AED';
  String dropDownValueFrom = 'AED';
  dynamic converted = TextEditingController()..text = '0';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 200,
        width: 400,
        decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Enter Amount :",
                  style: Theme.of(context).textTheme.bodyText2),
              Row(
                children: [
                  SizedBox(
                    width: 260,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 5),
                        filled: true,
                        fillColor: const Color(0xFFF4F6F9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyText1,
                      onChanged: (text) {
                        if (text != "") {
                          amount = text;
                          convertAmount().then((result) {
                            setState(() {
                              converted.text = result;
                            });
                          });
                        } else {
                          setState(() {
                            amount = '0';
                            converted.text = '0';
                          });
                        }
                      },
                    ),
                  ),
                  DropdownButton(
                    dropdownColor: const Color(0xFFFFFFFF),
                    underline: const SizedBox(),
                    value: dropDownValueFrom,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 25,
                      color: Color(0xFF103863),
                    ),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(items,
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        from = newValue!;
                        dropDownValueFrom = newValue;
                        convertAmount().then((result) {
                          setState(() {
                            converted.text = result;
                          });
                        });
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Converted Amount :",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 260,
                    child: TextField(
                      controller: converted,
                      enabled: false,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 5),
                        filled: true,
                        fillColor: const Color(0xFFF4F6F9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  DropdownButton(
                    dropdownColor: const Color(0xFFFFFFFF),
                    underline: const SizedBox(),
                    value: dropDownValueTo,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 25,
                      color: Color(0xFF103863),
                    ),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(
                            items,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      to = newValue!;
                      dropDownValueTo = newValue;
                      convertAmount().then((result) {
                        setState(() {
                          converted.text = result;
                        });
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> convertAmount() async {
    if (amount != '0') {
      String urlString =
          'https://api.exchangerate.host/convert?from=$from&to=$to&amount=$amount&places=3';
      var url = Uri.parse(urlString);
      http.Response response = await http.get(url);
      var responseBody = response.body;
      var parsedResponse = jsonDecode(responseBody);
      return parsedResponse['result'].toString();
    } else {
      return '0';
    }
  }
}

Future<List> fetchExchangeRates(String base) async {
  var exchangeRatesData = [];
  String urlString =
      'https://api.exchangerate.host/latest?base=$base&symbols=AED,CNY,GBP,PKR,SAR,USD&places=3';
  var url = Uri.parse(urlString);
  http.Response response = await http.get(url);
  var responseBody = response.body;
  var parsedResponse = jsonDecode(responseBody);
  exchangeRatesData.add(['AED', parsedResponse['rates']['AED'].toString()]);
  exchangeRatesData.add(['CNY', parsedResponse['rates']['CNY'].toString()]);
  exchangeRatesData.add(['GBP', parsedResponse['rates']['GBP'].toString()]);
  exchangeRatesData.add(['PKR', parsedResponse['rates']['PKR'].toString()]);
  exchangeRatesData.add(['SAR', parsedResponse['rates']['SAR'].toString()]);
  exchangeRatesData.add(['USD', parsedResponse['rates']['USD'].toString()]);
  return exchangeRatesData;
}

class ExchangeRateInfo extends StatefulWidget {
  String baseCurrency;
  ExchangeRateInfo(this.baseCurrency);
  @override
  State<ExchangeRateInfo> createState() => _ExchangeRateInfoState();
}

class _ExchangeRateInfoState extends State<ExchangeRateInfo> {
  String dropdownvalue = 'AED';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 300,
      width: 400,
      decoration: BoxDecoration(
        image: const DecorationImage(image: AssetImage('assets/bg.jpeg')),
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 2.5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Base Currency :",
                  style: Theme.of(context).textTheme.bodyText2),
              DropdownButton(
                dropdownColor: const Color(0xFFFFFFFF),
                underline: const SizedBox(),
                value: dropdownvalue,
                icon: const Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 25,
                    color: Color(0xFF113D6B),
                  ),
                ),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        items,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.baseCurrency = newValue!;
                    dropdownvalue = newValue;
                  });
                },
              ),
            ],
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List;
                  for (int m = 0; m < data.length; m++) {
                    if (widget.baseCurrency == data[m][0]) {
                      data.removeWhere(
                          (item) => item[0] == widget.baseCurrency);
                    }
                  }
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DataTableTheme(
                        data: Theme.of(context).dataTableTheme,
                        child: DataTable(
                          columns: const [
                            DataColumn(
                              label: Text(
                                'Country',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Symbol',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Rate',
                              ),
                            ),
                          ],
                          rows: [
                            for (int n = 0; n < data.length; n++)
                              DataRow(
                                cells: [
                                  DataCell(
                                    Image.asset(
                                      getFlag(data[n][0]),
                                      height: 20,
                                      width: 20,
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      data[n][0].toString(),
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      data[n][1].toString(),
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
              return const Padding(
                padding: EdgeInsets.only(top: 80),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            future: fetchExchangeRates(widget.baseCurrency),
          ),
        ],
      ),
    );
  }
}

String getFlag(String symbol) {
  if (symbol == "AED") {
    return "assets/are.png";
  } else if (symbol == "CNY") {
    return "assets/chn.png";
  } else if (symbol == "GBP") {
    return "assets/gbr.png";
  } else if (symbol == "PKR") {
    return "assets/pak.png";
  } else if (symbol == "SAR") {
    return "assets/sa.png";
  } else if (symbol == "USD") {
    return "assets/usa.png";
  } else {
    return "assets/white.png";
  }
}
