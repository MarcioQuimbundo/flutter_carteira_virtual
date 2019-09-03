import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_wallet/src/blocs/card_bloc.dart';
import 'package:flutter_card_wallet/src/ui/pages/card_create_page.dart';
import 'package:flutter_card_wallet/src/ui/widgets/my_appbar.dart';

class CardType extends StatelessWidget {
  final _buildTextInfo = Padding(
    padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
    child: Text.rich(
      TextSpan(
          text:
              "You can now add gift cards with a specific balance into wallet. When the card hits \$0.00 it will automatically disapear. Want to know if your gift card will link?",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14.0,
          ),
          children: <TextSpan>[
            TextSpan(
                text: " Learn More",
                style: TextStyle(
                    color: Colors.lightBlue, fontWeight: FontWeight.bold))
          ]),
      softWrap: true,
      textAlign: TextAlign.center,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        appBarTitle: "Select Type",
        leadingIcon: Icons.clear,
        context: context,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildRaisedButton(
                buttonColor: Colors.lightBlue,
                buttonText: "Credit Card",
                textColor: Colors.white,
                context: context),
            _buildRaisedButton(
                buttonColor: Colors.grey[200],
                buttonText: "Debit Card",
                textColor: Colors.grey[600],
                context: context),
            _buildRaisedButton(
                buttonColor: Colors.grey[200],
                buttonText: "Gift Card",
                textColor: Colors.grey[600],
                context: context),
            _buildTextInfo,
          ],
        ),
      ),
    );
  }

  Widget _buildRaisedButton(
      {Color buttonColor,
      String buttonText,
      Color textColor,
      BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.0),
      child: RaisedButton(
        elevation: 10.0,
        onPressed: () {
          var blocProviderCardCreate = BlocProvider(
            bloc: CardBloc(),
            child: CardCreatePage(),
          );
          blocProviderCardCreate.bloc.selectCardType(buttonText);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => blocProviderCardCreate));
        },
        color: buttonColor,
        child: Text(
          buttonText,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
