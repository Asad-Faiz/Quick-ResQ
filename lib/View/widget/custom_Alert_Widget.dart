// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../MenuItems/Home.dart';

void showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Details Submited'),
        content: Text('Location Sent'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              final Uri url = Uri(
                scheme: 'tel',
                path: '1122',
              );
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                log("cannot open url");
              }
              // Navigator.of(context).pop();
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(
                  context, CupertinoPageRoute(builder: (context) => Home()));
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
