import 'package:flutter/material.dart';

import 'AddressPage.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  AddAddres1() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddressPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment "),
      ),
      body: Column(children: [
        Container(
          width: w,
          height: h * .8,
          child: Column(children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: w * .55,
                      child: Text(
                          "sp 21 Home properties laxmi nagar, Raj Kot, Jaipur, Rajasthan 302030"),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      width: w * .35,
                      child: ElevatedButton(
                          child: Text("Add Address"),
                          onPressed: () => AddAddres1()),
                    )
                  ]),
            ),
            SizedBox(
              height: 2,
              width: w * .9,
              child: Container(
                color: Colors.amber,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Text("Select Payment Mode"),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(20)),
              width: w,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Cards,UPI & More",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
                padding: EdgeInsets.all(0),
                /* decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(15)), */
                width: w,
                height: h * .57,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      width: w,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 254, 254, 254))),
                          child: ListTile(
                            title: Text(
                              "Card",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Visa Mastercard,Rupay & more"),
                            leading: Image.asset("assets/images/icons/card.png",
                                height: 35),
                          ),
                          onPressed: () => {}),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      width: w,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 254, 254, 254))),
                          child: ListTile(
                            title: Text(
                              "UPI &QR",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Image.asset(
                              "assets/images/icons/upi.png",
                              height: 20,
                            ),
                            leading: Image.asset("assets/images/icons/upi1.png",
                                height: 35),
                          ),
                          onPressed: () => {}),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      width: w,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 254, 254, 254))),
                          child: ListTile(
                            title: Text(
                              "Net Banking",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("All Indian Banks"),
                            leading: Image.asset("assets/images/icons/net.png",
                                height: 35),
                          ),
                          onPressed: () => {}),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      width: w,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 254, 254, 254))),
                          child: ListTile(
                            title: Text(
                              "Wallet",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("PhonePe & More"),
                            leading: Image.asset(
                                "assets/images/icons/wallet.png",
                                height: 35),
                          ),
                          onPressed: () => {}),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      width: w,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 254, 254, 254))),
                          child: ListTile(
                            title: Text(
                              "EMI",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle:
                                Text("EMI via Debit/Credit cards sbi &more"),
                            leading: Image.asset("assets/images/icons/emi.png",
                                height: 35),
                          ),
                          onPressed: () => {}),
                    ),
                  ],
                )),
          ]),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 251, 251, 251),
              boxShadow: [
                new BoxShadow(
                  color: Color.fromARGB(255, 216, 216, 216),
                  blurRadius: 5.0,
                )
              ]),
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: w,
          height: h * .08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text("Rs.2000/-"),
              ),
              Container(
                child: ElevatedButton(
                    child: Text(
                      "Payment Now",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onPressed: () => {}),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
