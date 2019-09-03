import 'package:flutter/material.dart';

class MyAppBar extends AppBar {
  MyAppBar({String appBarTitle, IconData leadingIcon, BuildContext context})
      : super(
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(appBarTitle,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600)),
          leading: IconButton(
            icon: Icon(
              leadingIcon,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
}
