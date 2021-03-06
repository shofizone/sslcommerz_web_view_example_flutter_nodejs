import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_sslcommerz_example/payment_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SSLCzPayment WebView Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'SSLCzPayment'),
    );
  }
}

class SSLCzPayment {
  Map<String, dynamic> data;
  bool isLiveMode;

  SSLCzPayment(this.data, this.isLiveMode);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final siteDomain = "http://192.168.0.104:8000"; // put your ip and port

class _MyHomePageState extends State<MyHomePage> {
  bool isLive = false;
  Map<String,dynamic> data = {
    "ipn_url": "$siteDomain/api/ssl-ipn/",
    "store_id": 'testbox',
    "store_passwd": 'qwerty',
    "total_amount" : 100,
    "currency": 'BDT',
    "tran_id": 'REF123',
    "success_url": "$siteDomain/payment-success",
    "fail_url": "$siteDomain/payment-failed",
    "cancel_url": "$siteDomain/payment-failed",
    "shipping_method": 'Courier',
    "product_name": 'Computer.',
    "product_category": 'Electronic',
    "product_profile": 'general',
    "cus_name": 'Customer Name',
    "cus_email": 'cust@email.com',
    "cus_add1": 'Dhaka',
    "cus_add2": 'Dhaka',
    "cus_city": 'Dhaka',
    "cus_state": 'Dhaka',
    "cus_postcode": '1207',
    "cus_country": 'Bangladesh',
    "cus_phone": '01711111111',
    "cus_fax": '01711111111',
    "ship_name": 'Customer Name',
    "ship_add1": 'Dhaka',
    "ship_add2": 'Dhaka',
    "ship_city": 'Dhaka',
    "ship_state": 'Dhaka',
    "ship_postcode": 1207,
    "ship_country": 'Bangladesh',
    "multi_card_name": 'mastercard',
    "value_a": 'ref001_A',
    "value_b": 'ref002_B',
    "value_c": 'ref003_C',
    "value_d": 'ref004_D'
  };
  Map<String, dynamic>? paymentResult = {};

  initiatePayment() async {
    var directApiUrl = !isLive
        ? "https://sandbox.sslcommerz.com/gwprocess/v4/api.php"
        : "https://securepay.sslcommerz.com/gwprocess/v4/api.php";
    try {

      var res = await Dio().post(directApiUrl, data: FormData.fromMap(data));
      print(res.statusCode);
      print(res.data);
      if(res.data['status'] == "SUCCESS"){
        // proceed payment
        var gatewayPageURL = res.data['GatewayPageURL'];
        if(gatewayPageURL != null)
        Navigator.of(context)
             .push(MaterialPageRoute(builder: (context) => PaymentScreen(gatewayPageURL))).then((value) {
               paymentResult = value;
               setState(() {});
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("$paymentResult"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          initiatePayment();
        },
        tooltip: 'Payment',
        child: Icon(Icons.payment),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
