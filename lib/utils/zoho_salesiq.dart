// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, camel_case_types, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:salesiq_mobilisten/salesiq_mobilisten.dart';
import 'dart:io' as io;

class zohoSalesIQchat extends StatefulWidget {
  @override
  _zohoSalesIQchatState createState() => _zohoSalesIQchatState();
}

class _zohoSalesIQchatState extends State<zohoSalesIQchat> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
    initMobilisten();
  }

  Future<void> initMobilisten() async {
    if (io.Platform.isAndroid) {
      String appKey;
      String accessKey;

      appKey =
          "N3E2i91X8CCGxg2muZ3oOag7844mrFk%2FuttuPFh0ghsUWOtL4b5KMnM6upEOjBC0";
      accessKey =
          "VXYedrQX8SlVCETi4BG1v5u6QXMEH9R40tX067B1HRLmE0othNMdKUz4vjfDyk%2B3M%2Fh%2BB%2BGmAeye5vZHC6E%2BZIn2I%2BgdGsNFU2FhPPy8EGjzG2TSqw5AwXb0JhGFBIOYX%2B6AaADln8s8B3%2BIHW8Hhkor6XqWehwPR26QYyB3LKy2OyZh8CwgzA%3D%3D";
      ZohoSalesIQ.init(appKey, accessKey).then((context) {
        // initialization successful
        ZohoSalesIQ.showLauncher(true);
      }).catchError((error) {
        // initialization failed
        debugPrint(error);
      });
      // ZohoSalesIQ.setThemeColorForiOS("#6d85fc");
    }
  }

  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
