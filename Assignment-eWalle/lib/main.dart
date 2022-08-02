import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    //Dark Theme
    theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF171821),
        primaryColor: const Color(0xFF212130),
        splashColor: const Color(0xFF0F1314),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFCAC2D),
          foregroundColor: Color(0xFF171821),
        ),
        listTileTheme: const ListTileThemeData(iconColor: Color(0xFF797990)),
        textTheme: const TextTheme(
            bodyText1: TextStyle(color: Color(0xFF797990)),
            bodyText2: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF797990),
            ),
            headline1: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
            subtitle1: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: "SourceSansPro")),
        iconTheme: const IconThemeData(color: Color(0xFF797990), size: 30)),
    //Light Theme
    // theme: ThemeData.light().copyWith(
    //     scaffoldBackgroundColor: const Color(0xFFFDFDFD),
    //     primaryColor: const Color(0xFFD6D6DB),
    //     splashColor: const Color(0xFFFFFFFF),
    //     floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //       backgroundColor: Color(0xFFFCAC2D),
    //       foregroundColor: Color(0xFF171821),
    //     ),
    //     listTileTheme: const ListTileThemeData(iconColor: Color(0xFF343049)),
    //     textTheme: const TextTheme(
    //         bodyText1: TextStyle(color: Color(0xFF343049)),
    //         bodyText2: TextStyle(
    //           fontSize: 17,
    //           fontWeight: FontWeight.bold,
    //           color: Color(0xFF343049),
    //         ),
    //         headline1: TextStyle(
    //           fontSize: 27,
    //           fontWeight: FontWeight.bold,
    //           color: Color(0xFF181A1C),
    //         ),
    //         subtitle1: TextStyle(
    //             color: Color(0xFF2C2B31),
    //             fontSize: 25,
    //             fontWeight: FontWeight.bold,
    //             fontFamily: "SourceSansPro")),
    //     iconTheme: const IconThemeData(color: Color(0xFF343049), size: 30)),
    home: const SafeArea(
        child: Scaffold(
      body: EwalleApp(),
    )),
  ));
}

class EwalleApp extends StatelessWidget {
  const EwalleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            leading: Image.asset('assets/logo.png'),
            title: const Text("eWalle"),
            trailing: const Icon(Icons.widgets_rounded),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Text("Account Overview", textAlign: TextAlign.left),
                const SizedBox(height: 15),
                const AccountOverviewContainer(),
                const SizedBox(height: 15),
                SectionHeadingandIcon(
                  "Send Money",
                  const Icon(Icons.fit_screen_rounded),
                ),
                const SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FloatingActionButton(
                        onPressed: () {},
                        child: const Icon(Icons.add),
                      ),
                      AvatarContainer(
                          const AssetImage('assets/Avatar1.png'), "Mike"),
                      AvatarContainer(
                          const AssetImage('assets/Avatar2.png'), "Joshpeh"),
                      AvatarContainer(
                          const AssetImage('assets/Avatar3.png'), "Ash")
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                SectionHeadingandIcon(
                  "Services",
                  const Icon(Icons.tune),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ServiceContainer(
                        const Icon(Icons.currency_rupee), "Send", "Money"),
                    ServiceContainer(
                        const Icon(Icons.currency_rupee), "Receive", "Money"),
                    ServiceContainer(
                        const Icon(Icons.phone_android), "Mobile", "Prepaid"),
                    ServiceContainer(
                        const Icon(Icons.bolt), "Electricity", "Bill")
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ServiceContainer(
                        const Icon(Icons.style), "Cashback", "Offer"),
                    ServiceContainer(
                        const Icon(Icons.scanner), "Movie", "Tickets"),
                    ServiceContainer(
                        const Icon(Icons.flight), "Flight", "Tickets"),
                    ServiceContainer(
                        const Icon(Icons.grid_view_outlined), "More", "Options")
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccountOverviewContainer extends StatelessWidget {
  const AccountOverviewContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("20,600", style: Theme.of(context).textTheme.headline1),
              const SizedBox(height: 10),
              Text(
                "Current Balance",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          const SizedBox(width: 50),
          Column(
            children: [
              FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SectionHeadingandIcon extends StatelessWidget {
  final String sectiontext;
  final Icon sectionicon;
  SectionHeadingandIcon(this.sectiontext, this.sectionicon);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectiontext,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        sectionicon,
      ],
    );
  }
}

class AvatarContainer extends StatelessWidget {
  final AssetImage avatarimage;
  final String avatarname;
  AvatarContainer(this.avatarimage, this.avatarname);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor),
      child: Column(
        children: [
          CircleAvatar(
              radius: 25,
              foregroundImage: avatarimage,
              backgroundColor: Theme.of(context).splashColor),
          const SizedBox(
            height: 10,
          ),
          Text(
            avatarname,
            style: Theme.of(context).textTheme.bodyText1,
          )
        ],
      ),
    );
  }
}

class ServiceContainer extends StatelessWidget {
  Icon serviceicon;
  String servicetext1;
  String servicetext2;
  ServiceContainer(this.serviceicon, this.servicetext1, this.servicetext2);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor),
          child: serviceicon,
        ),
        Text(
          servicetext1,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Text(
          servicetext2,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }
}
