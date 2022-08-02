import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class UpdateExpense extends StatefulWidget {
  String receivedDocId;
  String receivedCategory;
  String receivedDesc;
  String receivedAmount;
  String receivedAmountUnchanged;
  String receivedDate;

  // ignore: use_key_in_widget_constructors
  UpdateExpense(this.receivedDocId, this.receivedCategory, this.receivedDesc,
      this.receivedAmount, this.receivedAmountUnchanged, this.receivedDate);

  @override
  State<UpdateExpense> createState() => _UpdateExpenseState();
}

class _UpdateExpenseState extends State<UpdateExpense> {
  Color foodcolor = const Color(0xFF9DA1A9);
  Color foodIconColor = const Color(0xFF9DA1A9);
  Color grocerycolor = const Color(0xFF9DA1A9);
  Color groceryIconColor = const Color(0xFF9DA1A9);
  Color fuelcolor = const Color(0xFF9DA1A9);
  Color fuelIconColor = const Color(0xFF9DA1A9);
  Color clothescolor = const Color(0xFF9DA1A9);
  Color clothesIconColor = const Color(0xFF9DA1A9);
  Color medicolor = const Color(0xFF9DA1A9);
  Color mediIconColor = const Color(0xFF9DA1A9);
  Color travelcolor = const Color(0xFF9DA1A9);
  Color travelIconColor = const Color(0xFF9DA1A9);
  Color giftscolor = const Color(0xFF9DA1A9);
  Color giftsIconColor = const Color(0xFF9DA1A9);
  Color othercolor = const Color(0xFF9DA1A9);
  Color otherIconColor = const Color(0xFF9DA1A9);
  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    String docId = "";
    double remainingAmount = 0.0;

    String? getUserId() {
      if (FirebaseAuth.instance.currentUser != null) {
        return FirebaseAuth.instance.currentUser?.uid;
      }
      return "";
    }

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2015),
          lastDate: DateTime(2101));
      if (picked != null && picked != DateTime.now()) {
        setState(() {
          widget.receivedDate = DateFormat.yMd().format(picked);
        });
      }
    }

    void setIdandAmount() {
      final colRef =
          db.collection("Expenses").doc(getUserId()).collection("IncomeData");
      colRef
          .where('Month', isEqualTo: DateTime.now().month)
          .snapshots()
          .listen((event) {
        for (var doc in event.docs) {
          remainingAmount = doc.data()['Remaining'];
          docId = doc.id;
        }
      });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Update Expense',
                      style: Theme.of(context).textTheme.headline1,
                    )),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyText1,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) {
                    RegExp regex = RegExp(r'[0-9]{1,20}');
                    var textNotNull = text ?? "";
                    if (textNotNull.isEmpty) {
                      return 'Amount is required';
                    } else if (!regex.hasMatch(textNotNull)) {
                      return 'Amount not valid';
                    }
                    return null;
                  },
                  initialValue: widget.receivedAmount,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
                  ),
                  onChanged: (value) {
                    widget.receivedAmount = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyText1,
                  initialValue: widget.receivedDesc,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) {
                    // ignore: valid_regexps
                    RegExp regex =
                        RegExp(r'[a-zA-Z0-9\.\+\-\*\/\(\)\,]{1,100}');
                    var textNotNull = text ?? "";
                    if (textNotNull.isEmpty) {
                      return 'Description is required';
                    } else if (!regex.hasMatch(textNotNull)) {
                      return 'Description not valid';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                  onChanged: (value) {
                    widget.receivedDesc = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.receivedCategory = 'Food';
                          foodcolor = const Color(0xFF324B7C);
                          foodIconColor = const Color(0xFF324B7C);
                          grocerycolor = const Color(0xFF9DA1A9);
                          groceryIconColor = const Color(0xFF9DA1A9);
                          fuelcolor = const Color(0xFF9DA1A9);
                          fuelIconColor = const Color(0xFF9DA1A9);
                          clothescolor = const Color(0xFF9DA1A9);
                          clothesIconColor = const Color(0xFF9DA1A9);
                          medicolor = const Color(0xFF9DA1A9);
                          mediIconColor = const Color(0xFF9DA1A9);
                          travelcolor = const Color(0xFF9DA1A9);
                          travelIconColor = const Color(0xFF9DA1A9);
                          giftscolor = const Color(0xFF9DA1A9);
                          giftsIconColor = const Color(0xFF9DA1A9);
                          othercolor = const Color(0xFF9DA1A9);
                          otherIconColor = const Color(0xFF9DA1A9);
                        });
                      },
                      child: CategoryContainer(
                          FaIcon(
                            FontAwesomeIcons.utensils,
                            color: foodIconColor,
                          ),
                          'Food',
                          foodcolor),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.receivedCategory = 'Grocery';
                          foodcolor = const Color(0xFF9DA1A9);
                          foodIconColor = const Color(0xFF9DA1A9);
                          grocerycolor = const Color(0xFF324B7C);
                          groceryIconColor = const Color(0xFF324B7C);
                          fuelcolor = const Color(0xFF9DA1A9);
                          fuelIconColor = const Color(0xFF9DA1A9);
                          clothescolor = const Color(0xFF9DA1A9);
                          clothesIconColor = const Color(0xFF9DA1A9);
                          medicolor = const Color(0xFF9DA1A9);
                          mediIconColor = const Color(0xFF9DA1A9);
                          travelcolor = const Color(0xFF9DA1A9);
                          travelIconColor = const Color(0xFF9DA1A9);
                          giftscolor = const Color(0xFF9DA1A9);
                          giftsIconColor = const Color(0xFF9DA1A9);
                          othercolor = const Color(0xFF9DA1A9);
                          otherIconColor = const Color(0xFF9DA1A9);
                        });
                      },
                      child: CategoryContainer(
                          FaIcon(
                            FontAwesomeIcons.cartShopping,
                            color: groceryIconColor,
                          ),
                          'Grocery',
                          grocerycolor),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.receivedCategory = 'Fuel';
                          foodcolor = const Color(0xFF9DA1A9);
                          foodIconColor = const Color(0xFF9DA1A9);
                          grocerycolor = const Color(0xFF9DA1A9);
                          groceryIconColor = const Color(0xFF9DA1A9);
                          fuelcolor = const Color(0xFF324B7C);
                          fuelIconColor = const Color(0xFF324B7C);
                          clothescolor = const Color(0xFF9DA1A9);
                          clothesIconColor = const Color(0xFF9DA1A9);
                          medicolor = const Color(0xFF9DA1A9);
                          mediIconColor = const Color(0xFF9DA1A9);
                          travelcolor = const Color(0xFF9DA1A9);
                          travelIconColor = const Color(0xFF9DA1A9);
                          giftscolor = const Color(0xFF9DA1A9);
                          giftsIconColor = const Color(0xFF9DA1A9);
                          othercolor = const Color(0xFF9DA1A9);
                          otherIconColor = const Color(0xFF9DA1A9);
                        });
                      },
                      child: CategoryContainer(
                          FaIcon(
                            FontAwesomeIcons.gasPump,
                            color: fuelIconColor,
                          ),
                          'Fuel',
                          fuelcolor),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.receivedCategory = 'Clothes';
                          foodcolor = const Color(0xFF9DA1A9);
                          foodIconColor = const Color(0xFF9DA1A9);
                          grocerycolor = const Color(0xFF9DA1A9);
                          groceryIconColor = const Color(0xFF9DA1A9);
                          fuelcolor = const Color(0xFF9DA1A9);
                          fuelIconColor = const Color(0xFF9DA1A9);
                          clothescolor = const Color(0xFF324B7C);
                          clothesIconColor = const Color(0xFF324B7C);
                          medicolor = const Color(0xFF9DA1A9);
                          mediIconColor = const Color(0xFF9DA1A9);
                          travelcolor = const Color(0xFF9DA1A9);
                          travelIconColor = const Color(0xFF9DA1A9);
                          giftscolor = const Color(0xFF9DA1A9);
                          giftsIconColor = const Color(0xFF9DA1A9);
                          othercolor = const Color(0xFF9DA1A9);
                          otherIconColor = const Color(0xFF9DA1A9);
                        });
                      },
                      child: CategoryContainer(
                          FaIcon(
                            FontAwesomeIcons.shirt,
                            color: clothesIconColor,
                          ),
                          'Clothes',
                          clothescolor),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.receivedCategory = 'Medicine';
                          foodcolor = const Color(0xFF9DA1A9);
                          foodIconColor = const Color(0xFF9DA1A9);
                          grocerycolor = const Color(0xFF9DA1A9);
                          groceryIconColor = const Color(0xFF9DA1A9);
                          fuelcolor = const Color(0xFF9DA1A9);
                          fuelIconColor = const Color(0xFF9DA1A9);
                          clothescolor = const Color(0xFF9DA1A9);
                          clothesIconColor = const Color(0xFF9DA1A9);
                          medicolor = const Color(0xFF324B7C);
                          mediIconColor = const Color(0xFF324B7C);
                          travelcolor = const Color(0xFF9DA1A9);
                          travelIconColor = const Color(0xFF9DA1A9);
                          giftscolor = const Color(0xFF9DA1A9);
                          giftsIconColor = const Color(0xFF9DA1A9);
                          othercolor = const Color(0xFF9DA1A9);
                          otherIconColor = const Color(0xFF9DA1A9);
                        });
                      },
                      child: CategoryContainer(
                          FaIcon(
                            FontAwesomeIcons.pills,
                            color: mediIconColor,
                          ),
                          'Medicine',
                          medicolor),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.receivedCategory = 'Travel';
                          foodcolor = const Color(0xFF9DA1A9);
                          foodIconColor = const Color(0xFF9DA1A9);
                          grocerycolor = const Color(0xFF9DA1A9);
                          groceryIconColor = const Color(0xFF9DA1A9);
                          fuelcolor = const Color(0xFF9DA1A9);
                          fuelIconColor = const Color(0xFF9DA1A9);
                          clothescolor = const Color(0xFF9DA1A9);
                          clothesIconColor = const Color(0xFF9DA1A9);
                          medicolor = const Color(0xFF9DA1A9);
                          mediIconColor = const Color(0xFF9DA1A9);
                          travelcolor = const Color(0xFF324B7C);
                          travelIconColor = const Color(0xFF324B7C);
                          giftscolor = const Color(0xFF9DA1A9);
                          giftsIconColor = const Color(0xFF9DA1A9);
                          othercolor = const Color(0xFF9DA1A9);
                          otherIconColor = const Color(0xFF9DA1A9);
                        });
                      },
                      child: CategoryContainer(
                          FaIcon(
                            FontAwesomeIcons.planeUp,
                            color: travelIconColor,
                          ),
                          'Travel',
                          travelcolor),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.receivedCategory = 'Gifts';
                          foodcolor = const Color(0xFF9DA1A9);
                          foodIconColor = const Color(0xFF9DA1A9);
                          grocerycolor = const Color(0xFF9DA1A9);
                          groceryIconColor = const Color(0xFF9DA1A9);
                          fuelcolor = const Color(0xFF9DA1A9);
                          fuelIconColor = const Color(0xFF9DA1A9);
                          clothescolor = const Color(0xFF9DA1A9);
                          clothesIconColor = const Color(0xFF9DA1A9);
                          medicolor = const Color(0xFF9DA1A9);
                          mediIconColor = const Color(0xFF9DA1A9);
                          travelcolor = const Color(0xFF9DA1A9);
                          travelIconColor = const Color(0xFF9DA1A9);
                          giftscolor = const Color(0xFF324B7C);
                          giftsIconColor = const Color(0xFF324B7C);
                          othercolor = const Color(0xFF9DA1A9);
                          otherIconColor = const Color(0xFF9DA1A9);
                        });
                      },
                      child: CategoryContainer(
                          FaIcon(
                            FontAwesomeIcons.gift,
                            color: giftsIconColor,
                          ),
                          'Gifts',
                          giftscolor),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.receivedCategory = 'Other';
                          foodcolor = const Color(0xFF9DA1A9);
                          foodIconColor = const Color(0xFF9DA1A9);
                          grocerycolor = const Color(0xFF9DA1A9);
                          groceryIconColor = const Color(0xFF9DA1A9);
                          fuelcolor = const Color(0xFF9DA1A9);
                          fuelIconColor = const Color(0xFF9DA1A9);
                          clothescolor = const Color(0xFF9DA1A9);
                          clothesIconColor = const Color(0xFF9DA1A9);
                          medicolor = const Color(0xFF9DA1A9);
                          mediIconColor = const Color(0xFF9DA1A9);
                          travelcolor = const Color(0xFF9DA1A9);
                          travelIconColor = const Color(0xFF9DA1A9);
                          giftscolor = const Color(0xFF9DA1A9);
                          giftsIconColor = const Color(0xFF9DA1A9);
                          othercolor = const Color(0xFF324B7C);
                          otherIconColor = const Color(0xFF324B7C);
                        });
                      },
                      child: CategoryContainer(
                          FaIcon(
                            FontAwesomeIcons.question,
                            color: otherIconColor,
                          ),
                          'Other',
                          othercolor),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Date:${widget.receivedDate}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Select date'),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      try {
                        setIdandAmount();
                        if (remainingAmount >
                            double.parse(widget.receivedAmount)) {
                          final dataToSave = <String, dynamic>{
                            'Category': widget.receivedCategory,
                            'Date': widget.receivedDate,
                            'Description': widget.receivedDesc,
                            'Amount': double.parse(widget.receivedAmount),
                          };

                          db
                              .collection("Expenses")
                              .doc(getUserId())
                              .collection("ExpenseData")
                              .doc(widget.receivedDocId)
                              .update(dataToSave);

                          double remaining = remainingAmount +
                              double.parse(widget.receivedAmountUnchanged) -
                              double.parse(widget.receivedAmount);
                          final data = {"Remaining": remaining};
                          db
                              .collection("Expenses")
                              .doc(getUserId())
                              .collection("IncomeData")
                              .doc(docId)
                              .update(data);
                          Flushbar(
                            margin: const EdgeInsets.all(8),
                            borderRadius: BorderRadius.circular(8),
                            flushbarStyle: FlushbarStyle.FLOATING,
                            backgroundColor: const Color(0xFFF2F7FA),
                            icon: const Icon(
                              Icons.check_circle_outline_outlined,
                              size: 28.0,
                              color: Colors.green,
                            ),
                            titleText: Text('Update Success',
                                style: Theme.of(context).textTheme.bodyText2),
                            messageText: Text('Expense information is updated!',
                                style: Theme.of(context).textTheme.bodyText1),
                            duration: const Duration(seconds: 3),
                          ).show(context);
                        }
                      } catch (error) {
                        Flushbar(
                          margin: const EdgeInsets.all(8),
                          borderRadius: BorderRadius.circular(8),
                          flushbarStyle: FlushbarStyle.FLOATING,
                          backgroundColor: const Color(0xFFF2F7FA),
                          icon: const Icon(
                            Icons.highlight_off_outlined,
                            size: 28.0,
                            color: Colors.red,
                          ),
                          titleText: Text('Update Failed',
                              style: Theme.of(context).textTheme.bodyText2),
                          messageText: Text('Something went wrong!',
                              style: Theme.of(context).textTheme.bodyText1),
                          duration: const Duration(seconds: 3),
                        ).show(context);
                      }
                    },
                    child: const Text('Update')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Back'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CategoryContainer extends StatelessWidget {
  FaIcon categoryIcon;
  String categoryText;
  Color color;
  // ignore: use_key_in_widget_constructors
  CategoryContainer(this.categoryIcon, this.categoryText, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 72.5,
      width: 72.5,
      decoration: BoxDecoration(
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFFFFFF)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          categoryIcon,
          Text(
            categoryText,
            style: TextStyle(color: color, fontSize: 15),
          )
        ],
      ),
    );
  }
}
