import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_sslcommerz_example/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String gatewayPageURL;


  PaymentScreen(this.gatewayPageURL);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isLoading = true;

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.gatewayPageURL,
            javascriptMode: JavascriptMode.unrestricted,
            javascriptChannels: <JavascriptChannel>[
              JavascriptChannel(
                  name: 'MessageInvoker',
                  onMessageReceived: (JavascriptMessage s) {
                    // print(s.message);
                    if(s.message != null){
                   Map<String,dynamic> data = json.decode(s.message);
                   if(data.containsKey("val_id")){
                     Navigator.of(context).pop<Map<String,dynamic>>(data);
                   }
                    }
                  }),
            ].toSet(),
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : SizedBox(),
        ],
      ),
    );
  }
}
