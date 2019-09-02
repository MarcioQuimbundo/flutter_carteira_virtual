import 'package:flutter/material.dart';
import 'package:flutter_card_wallet/src/ui/pages/card_type_page.dart';
import 'package:flutter_card_wallet/src/ui/widgets/card_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CardType()));
            },
          )
        ],
        title: Text(
          "Wallet",
          style: TextStyle(
              fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
      body: CardList(),
    );
  }
}
