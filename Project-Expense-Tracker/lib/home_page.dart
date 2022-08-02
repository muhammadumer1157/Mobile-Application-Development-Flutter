import 'package:expense_tracker/add_income.dart';
import 'package:expense_tracker/calculator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

String? userId = "";
String? getUserId() {
  if (FirebaseAuth.instance.currentUser != null) {
    return FirebaseAuth.instance.currentUser?.uid;
  }
  return "";
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    userId = getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Stack(
              children: [
                Container(
                  height: 400,
                  decoration: const BoxDecoration(
                      color: Color(0xFF0039A5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Expense Tracker",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Calculator()));
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.calculator,
                                  color: Color(0xFFFFFFFF),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          ("Income"),
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const IncomeCard(),
                        const SizedBox(height: 10),
                        DateTime.now().day == 1 || DateTime.now().day == 2
                            ? Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF2F7FA),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 50,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.info_outline,
                                      color: Color(0xFF1F1E3E),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Update your income!',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF2F7FA),
                                    borderRadius: BorderRadius.circular(10)),
                                height: 50,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.info_outline,
                                      color: Color(0xFF1F1E3E),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Have a good day!',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                              ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Recent',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(height: 5),
                        const BottomTransactions()
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IncomeCard extends StatefulWidget {
  const IncomeCard({Key? key}) : super(key: key);

  @override
  State<IncomeCard> createState() => _IncomeCardState();
}

class _IncomeCardState extends State<IncomeCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Color(0xFFFFFFFF),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [OutcomeData()],
          ),
          FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddIncome()));
              })
        ],
      ),
    );
  }
}

class BottomTransactions extends StatefulWidget {
  const BottomTransactions({Key? key}) : super(key: key);

  @override
  State<BottomTransactions> createState() => _BottomTransactionsState();
}

class _BottomTransactionsState extends State<BottomTransactions> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection("Expenses")
        .doc(userId)
        .collection("ExpenseData")
        .orderBy("Date", descending: true)
        .limit(3)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: dataStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text(
              'Add Transaction',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 17,
                color: Color(0xFFFFFFFF),
              ),
            ));
          }

          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  return Card(
                    child: ListTile(
                      leading: selectIcon(data['Category']),
                      title: Text(
                        data['Description'],
                        style: const TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 17,
                            color: Color(0xFF1F1E3E)),
                      ),
                      subtitle: Text(
                        data['Date'],
                        style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 12,
                          color: Color(0xFF9DA1A9),
                        ),
                      ),
                      trailing: Text(
                        'Rs.${data['Amount']}',
                        style: const TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 17,
                            color: Color(0xFF1F1E3E),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                })
                .toList()
                .cast(),
          );
        });
  }
}

Container selectIcon(String category) {
  if (category == 'Food') {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFFFAE03)),
        height: 50,
        width: 50,
        child: const Center(
            child:
                FaIcon(FontAwesomeIcons.utensils, color: Color(0xFFFFFFFF))));
  } else if (category == 'Grocery') {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF6865DD)),
        height: 50,
        width: 50,
        child: const Center(
          child:
              FaIcon(FontAwesomeIcons.cartShopping, color: Color(0xFFFFFFFF)),
        ));
  } else if (category == 'Fuel') {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFED7B1D)),
        height: 50,
        width: 50,
        child: const Center(
            child: FaIcon(FontAwesomeIcons.gasPump, color: Color(0xFFFFFFFF))));
  } else if (category == 'Clothes') {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF1DA0A7)),
        height: 50,
        width: 50,
        child: const Center(
            child: FaIcon(FontAwesomeIcons.shirt, color: Color(0xFFFFFFFF))));
  } else if (category == 'Medicine') {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFFFAE03)),
        height: 50,
        width: 50,
        child: const Center(
            child: FaIcon(FontAwesomeIcons.pills, color: Color(0xFFFFFFFF))));
  } else if (category == 'Travel') {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF6865DD)),
        height: 50,
        width: 50,
        child: const Center(
            child: FaIcon(FontAwesomeIcons.planeUp, color: Color(0xFFFFFFFF))));
  } else if (category == 'Gifts') {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFED7B1D)),
        height: 50,
        width: 50,
        child: const Center(
            child: FaIcon(FontAwesomeIcons.gift, color: Color(0xFFFFFFFF))));
  } else {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF1DA0A7)),
        height: 50,
        width: 50,
        child: const Center(
            child:
                FaIcon(FontAwesomeIcons.question, color: Color(0xFFFFFFFF))));
  }
}

class OutcomeData extends StatefulWidget {
  const OutcomeData({Key? key}) : super(key: key);

  @override
  State<OutcomeData> createState() => _OutcomeDataState();
}

class _OutcomeDataState extends State<OutcomeData> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection("Expenses")
        .doc(userId)
        .collection("IncomeData")
        .where('Month', isEqualTo: DateTime.now().month)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: dataStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text(
              'Add Income',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 17,
                color: Color(0xFF1F1E3E),
              ),
            ));
          } else {
            List<DocumentSnapshot> items = snapshot.data!.docs;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "This Month's Income:",
                  style: TextStyle(
                      fontFamily: 'Lato',
                      color: Color(0xFF1F1E3E),
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  items[0]['Income'].toString(),
                  style: const TextStyle(
                      fontFamily: 'Lato',
                      color: Color(0xFF1F1E3E),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Remaining Income:',
                  style: TextStyle(
                      fontFamily: 'Lato',
                      color: Color(0xFF1F1E3E),
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  items[0]['Remaining'].toString(),
                  style: const TextStyle(
                      fontFamily: 'Lato',
                      color: Color(0xFF1F1E3E),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )
              ],
            );
          }
        });
  }
}
