import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/home_page.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  double foodTotalVal = 0.0;
  double groceryTotalVal = 0.0;
  double fuelTotalVal = 0.0;
  double travelTotalVal = 0.0;
  double clothesTotalVal = 0.0;
  double medicineTotalVal = 0.0;
  double giftsTotalVal = 0.0;
  double otherTotalVal = 0.0;
  Map<String, double> dataMap = {};
  final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
      .collection("Expenses")
      .doc(userId)
      .collection("IncomeData")
      .snapshots();

  void getDataFood() {
    double foodTotal = 0.0;
    db
        .collection('Expenses')
        .doc(userId)
        .collection('ExpenseData')
        .where('Category', isEqualTo: 'Food')
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        foodTotal += doc.data()['Amount'];
      }
      foodTotalVal = foodTotal;
    });
  }

  void getDataGrocery() {
    double groceryTotal = 0.0;
    db
        .collection('Expenses')
        .doc(userId)
        .collection('ExpenseData')
        .where('Category', isEqualTo: 'Grocery')
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        groceryTotal += doc.data()['Amount'];
      }
      groceryTotalVal = groceryTotal;
    });
  }

  void getDatafuel() {
    double fuelTotal = 0.0;
    db
        .collection('Expenses')
        .doc(userId)
        .collection('ExpenseData')
        .where('Category', isEqualTo: 'Fuel')
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        fuelTotal += doc.data()['Amount'];
      }
      fuelTotalVal = fuelTotal;
    });
  }

  void getDataClothes() {
    double clothesTotal = 0.0;
    db
        .collection('Expenses')
        .doc(userId)
        .collection('ExpenseData')
        .where('Category', isEqualTo: 'Clothes')
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        clothesTotal += doc.data()['Amount'];
      }
      clothesTotalVal = clothesTotal;
    });
  }

  void getDataMedicine() {
    double mediTotal = 0.0;
    db
        .collection('Expenses')
        .doc(userId)
        .collection('ExpenseData')
        .where('Category', isEqualTo: 'Medicine')
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        mediTotal += doc.data()['Amount'];
      }
      medicineTotalVal = mediTotal;
    });
  }

  void getDataTravel() {
    double travelTotal = 0.0;
    db
        .collection('Expenses')
        .doc(userId)
        .collection('ExpenseData')
        .where('Category', isEqualTo: 'Travel')
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        travelTotal += doc.data()['Amount'];
      }
      travelTotalVal = travelTotal;
    });
  }

  void getDataGifts() {
    double giftsTotal = 0.0;
    db
        .collection('Expenses')
        .doc(userId)
        .collection('ExpenseData')
        .where('Category', isEqualTo: 'Gifts')
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        giftsTotal += doc.data()['Amount'];
      }
      giftsTotalVal = giftsTotal;
    });
  }

  void getDataOther() {
    double otherTotal = 0.0;
    db
        .collection('Expenses')
        .doc(userId)
        .collection('ExpenseData')
        .where('Category', isEqualTo: 'Other')
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        otherTotal += doc.data()['Amount'];
      }
      otherTotalVal = otherTotal;
    });
  }

  bool isShown = false;

  void changeVisibility() {
    setState(() {
      isShown = !isShown;
    });
  }

  bool isShownStream = true;

  void changeVisibilityStream() {
    setState(() {
      isShownStream = !isShownStream;
    });
  }

  @override
  void initState() {
    getDataFood();
    getDataClothes();
    getDatafuel();
    getDataGifts();
    getDataGrocery();
    getDataMedicine();
    getDataTravel();
    getDataOther();
    dataMap = {
      'Food': foodTotalVal,
      'Grocery': groceryTotalVal,
      'Fuel': fuelTotalVal,
      'Clothes': clothesTotalVal,
      'Medicine': medicineTotalVal,
      'Travel': travelTotalVal,
      'Gifts': giftsTotalVal,
      'Other': otherTotalVal
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Statistics',
                    style: Theme.of(context).textTheme.headline1,
                  )),
              Visibility(
                visible: isShownStream,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Income Stats',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: dataStream,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const CircularProgressIndicator();
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Text(
                              'Add Income',
                              style: TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 17,
                                color: Color(0xFF1F1E3E),
                              ),
                            );
                          }
                          return ListView(
                            shrinkWrap: true,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;

                                  return Card(
                                    child: ListTile(
                                        leading: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: const Color(0xFF3161BB)),
                                            child: Center(
                                                child: Text(
                                              data['Month'].toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontSize: 20,
                                                  color: Color(0xFFFFFFFF),
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                        title: Text(
                                          "Income: ${data['Income']}",
                                          style: const TextStyle(
                                              fontFamily: 'Lato',
                                              color: Color(0xFF1F1E3E),
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          "Remaining: ${data['Remaining']}",
                                          style: const TextStyle(
                                              fontFamily: 'Lato',
                                              color: Color(0xFF1F1E3E),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        )),
                                  );
                                })
                                .toList()
                                .cast(),
                          );
                        }),
                  ],
                ),
              ),
              Visibility(
                visible: isShown,
                child: Column(
                  children: [
                    PieChart(
                      dataMap: dataMap,
                      animationDuration: const Duration(milliseconds: 800),
                      chartLegendSpacing: 32,
                      chartRadius: 150,
                      colorList: const [
                        Color(0xFF324B7C),
                        Color(0xFFFFAE03),
                        Color(0xFF6865DD),
                        Color(0xFFED7B1D),
                        Color(0xFF1DA0A7),
                        Color(0xFFF2F7FA),
                        Color(0xFF00B6E4),
                        Color(0xFF3161BB),
                      ],
                      initialAngleInDegree: 0,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 10,
                      legendOptions: const LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.right,
                        showLegends: true,
                        legendShape: BoxShape.circle,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F1E3E),
                        ),
                      ),
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValueBackground: true,
                        showChartValues: true,
                        showChartValuesInPercentage: true,
                        showChartValuesOutside: false,
                        decimalPlaces: 1,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Expense Stats',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 205,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: dataMap.length,
                        itemBuilder: (BuildContext context, int index) {
                          String key = dataMap.keys.elementAt(index);
                          return Card(
                            child: ListTile(
                              title: Text(
                                '$key: Rs.${dataMap[key]}',
                                style: const TextStyle(
                                    fontFamily: 'Lato',
                                    color: Color(0xFF1F1E3E),
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700),
                              ),
                              // subtitle: Text('${dataMap[key]}'),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        getDataFood();
                        getDataClothes();
                        getDatafuel();
                        getDataGifts();
                        getDataGrocery();
                        getDataMedicine();
                        getDataTravel();
                        getDataOther();
                        dataMap = {
                          'Food': foodTotalVal,
                          'Grocery': groceryTotalVal,
                          'Fuel': fuelTotalVal,
                          'Clothes': clothesTotalVal,
                          'Medicine': medicineTotalVal,
                          'Travel': travelTotalVal,
                          'Gifts': giftsTotalVal,
                          'Other': otherTotalVal
                        };
                      });
                      changeVisibility();
                      changeVisibilityStream();
                    },
                    child: const Text('Show/Hide Expense Stats')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
