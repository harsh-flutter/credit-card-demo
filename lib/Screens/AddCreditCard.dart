import 'package:flutter/material.dart';
import 'package:flutter_slide/Screens/HomeScreen.dart';
import 'package:flutter_slide/api.dart';
import 'package:flutter_slide/model/CardDetails.dart';
import 'package:get_storage/get_storage.dart';

List<Widget> _cardList = [];
final cardname_controller = TextEditingController();
final cardNumber_controller = TextEditingController();

final expiryDate_controller = TextEditingController();
final cardHolder_controller = TextEditingController();
final CVV_controller = TextEditingController();
final category_controller = TextEditingController();

class CreditDetails extends StatefulWidget {
  @override
  State<CreditDetails> createState() => _CreditDetailsState();
}

class _CreditDetailsState extends State<CreditDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add New Card",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: cardname_controller,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.card_membership),
                    border: OutlineInputBorder(),
                    labelText: 'Card Name',
                    hintText: 'Card Name',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: cardNumber_controller,
                  maxLength: 16,
                  maxLengthEnforced: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.credit_card),
                    border: OutlineInputBorder(),
                    labelText: 'Card Number',
                    hintText: 'Card Number',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: TextField(
                          controller: expiryDate_controller,
                          maxLength: 5,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.calendar_today_rounded),
                            border: OutlineInputBorder(),
                            labelText: 'Expiry Date',
                            hintText: 'MM / YY',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: TextField(
                          controller: CVV_controller,
                          maxLength: 3,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.info),
                            border: OutlineInputBorder(),
                            labelText: 'CVV / CVC',
                            hintText: '',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: cardHolder_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Card Holder's Name",
                    hintText: "Enter Card Holder's Full Name",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: category_controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Choose from MC/VISA/AE",
                    hintText: "MC/VISA/AE",
                  ),
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    onPressed: () {
                      // setState(() {
                      //   _cardList.add(_card());
                      // });
                      final userdata = GetStorage();
                      String cardname = cardname_controller.text;
                      String cardHolder = cardHolder_controller.text;
                      String cardNumber = cardNumber_controller.text;
                      String ExpiryDate = cardNumber_controller.text;
                      String CVV = cardNumber_controller.text;
                      String category = category_controller.text;

                      userdata.write('cardname', cardname);
                      userdata.write('cardHolder', cardHolder);
                      userdata.write('cardNumber', cardNumber);
                      userdata.write('expirydate', ExpiryDate);
                      userdata.write('CVV', CVV);
                      userdata.write('category', category);

                      String cardnameread =
                          '${userdata.read('cardname'.trim())}';
                      String cardHolderread =
                          '${userdata.read('CardHolderName'.trim())}';
                      String cardNumberread =
                          '${userdata.read('CardNumber'.trim())}';
                      String expiryDate =
                          '${userdata.read('ExpiryDate'.trim())}';
                      String cvv = '${userdata.read('CVV'.trim())}';
                      String categoryread =
                          '${userdata.read('category'.trim())}';

                      print("card Name:" + cardnameread);
                      print("card Holder Name:" + cardHolderread);
                      print("Card Number:" + cardNumberread);
                      print("Expiry Date:" + expiryDate);
                      print("CVV" + cvv);
                      print("Card Category" + categoryread);

                      CardDetails cardDetails = CardDetails(
                        name: cardnameread,
                        expiryDate: expiryDate,
                        cardHolder: cardHolderread,
                        cardNumber: cardNumberread,
                        cardCategory: categoryread,
                      );
                      APIService().postCardDetails(cardDetails).then((value) {
                        print('Success!!');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      }).onError((error, stackTrace) {
                        print('Failure!!  ${error.toString()}' );
                      });

                    },
                    child: Text("Add Card"),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
