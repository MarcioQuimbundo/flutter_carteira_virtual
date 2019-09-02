import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Wallet",
          style: TextStyle(
              fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
