import 'package:dar_sllah/classes/payment.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  static String routeName = "PaymentScreen";
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int group = 0;
  final List<Payment> paymentList = [
    Payment("assets/images/carte_edinar.png", "E-DINAR/Jeunne", 0),
    Payment("assets/images/carte_visa.png", "carte bancaire", 1),
    Payment("assets/images/flouci_logo.png", "Flouci", 2),
    Payment("assets/images/mobicash_logo.png", "MobiCash", 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Personal Info',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 18,
                  color: const Color(0xfffbce01),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 40, top: 20),
              child: TextField(
                decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Full Name",
                    labelText: "Full Name",
                    labelStyle: new TextStyle(color: const Color(0xFF424242))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 40, top: 20),
              child: TextField(
                decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.mail),
                    hintText: "Address Mail",
                    labelText: "Address Mail",
                    labelStyle: new TextStyle(color: const Color(0xFF424242))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 40, top: 20),
              child: TextField(
                decoration: new InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: "Phone Number",
                    labelText: "Phone Number",
                    labelStyle: new TextStyle(color: const Color(0xFF424242))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 30),
              child: Text(
                'Méthode de Payment',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 18,
                  color: const Color(0xfffbce01),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 420,
              child: GridView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  //element 1
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        height: 120,
                        child: Image.asset(paymentList[0].image),
                      ),
                      Text(
                        paymentList[0].name,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 13,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Radio(
                        value: paymentList[0].value,
                        groupValue: group,
                        onChanged: (value) {
                          group = value;
                          setState(() {
                            group = value;
                          });
                        },
                      )
                    ],
                  ),
                  //element 2
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        height: 120,
                        child: Image.asset(paymentList[1].image),
                      ),
                      Text(
                        paymentList[1].name,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 13,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Radio(
                        value: paymentList[1].value,
                        groupValue: group,
                        onChanged: (value) {
                          group = value;
                          setState(() {
                            group = value;
                          });
                        },
                      )
                    ],
                  ),
                  //element 3
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        height: 60,
                        child: Image.asset(paymentList[2].image),
                      ),
                      Text(
                        paymentList[1].name,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 13,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Radio(
                        value: paymentList[2].value,
                        groupValue: group,
                        onChanged: (value) {
                          group = value;
                          setState(() {
                            group = value;
                          });
                        },
                      )
                    ],
                  ),
                  //element 4
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        height: 40,
                        child: Image.asset(paymentList[3].image),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        paymentList[1].name,
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 13,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Radio(
                        value: paymentList[3].value,
                        groupValue: group,
                        onChanged: (value) {
                          group = value;
                          setState(() {
                            group = value;
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: GestureDetector(
                  onTap: () {
                    //do something
                  },
                  child: Center(
                    child: Image.asset("assets/images/check_out_btn.png"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
