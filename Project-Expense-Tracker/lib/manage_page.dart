import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'update_expense.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({Key? key}) : super(key: key);

  @override
  State<ManagePage> createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Manage',
                      style: Theme.of(context).textTheme.headline1,
                    )),
              ),
              const SizedBox(
                  height: 600,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: AllTransactions(),
                  )),
            ],
          ),
        )),
      ),
    );
  }
}

class AllTransactions extends StatefulWidget {
  const AllTransactions({Key? key}) : super(key: key);

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  String incomeDocId = "";
  double remainingAmount = 0.0;

  String? userId = "";
  String? getUserId() {
    if (FirebaseAuth.instance.currentUser != null) {
      return FirebaseAuth.instance.currentUser?.uid;
    }
    return "";
  }

  void setIdandAmount() {
    final colRef = FirebaseFirestore.instance
        .collection("Expenses")
        .doc(getUserId())
        .collection("IncomeData");
    colRef
        .where('Month', isEqualTo: DateTime.now().month)
        .snapshots()
        .listen((event) {
      for (var doc in event.docs) {
        incomeDocId = doc.id;
        remainingAmount = doc.data()['Remaining'];
      }
    });
  }

  Future<void> _deleteDialog(String id, String amount) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delete',
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F1E3E),
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Are you sure you want to delete?',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("Expenses")
                    .doc(userId)
                    .collection("ExpenseData")
                    .doc(id)
                    .delete();

                double remaining = remainingAmount + double.parse(amount);
                final data = {"Remaining": remaining};
                FirebaseFirestore.instance
                    .collection("Expenses")
                    .doc(userId)
                    .collection("IncomeData")
                    .doc(incomeDocId)
                    .update(data);
                setIdandAmount();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    setIdandAmount();
    userId = getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
        .collection("Expenses")
        .doc(userId)
        .collection("ExpenseData")
        .orderBy("Date", descending: true)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: dataStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const CircularProgressIndicator();
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Text(
              'Add Transaction',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 17,
                color: Color(0xFF1F1E3E),
              ),
            );
          }

          return ListView(
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Rs.${data['Amount']}',
                            style: const TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 17,
                                color: Color(0xFF1F1E3E),
                                fontWeight: FontWeight.bold),
                          ),
                          PopupMenuButton<int>(
                            itemBuilder: (context) => [
                              // PopupMenuItem 1
                              PopupMenuItem(
                                value: 1,
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.edit,
                                      color: Color(0xFF1F1E3E),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Edit",
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 15,
                                        color: Color(0xFF1F1E3E),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // PopupMenuItem 2
                              PopupMenuItem(
                                value: 2,
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.delete,
                                      color: Color(0xFF1F1E3E),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Delete",
                                      style: TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 15,
                                        color: Color(0xFF1F1E3E),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                            offset: const Offset(0, 35),
                            color: Colors.white,
                            elevation: 2,
                            onSelected: (value) {
                              if (value == 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateExpense(
                                            data['Id'],
                                            data['Category'],
                                            data['Description'],
                                            data['Amount'].toString(),
                                            data['Amount'].toString(),
                                            data['Date'])));
                              } else if (value == 2) {
                                _deleteDialog(
                                    data['Id'], data['Amount'].toString());
                              }
                            },
                          ),
                        ],
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
