import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_wallet/src/blocs/card_bloc.dart';
import 'package:flutter_card_wallet/src/ui/widgets/card_chip.dart';
import 'package:flutter_card_wallet/src/utils/card_color.dart';

class CardFront extends StatelessWidget {
  final int rotatedTurnsValue;
  CardFront({this.rotatedTurnsValue});

  @override
  Widget build(BuildContext context) {
    final CardBloc bloc = BlocProvider.of<CardBloc>(context);

    final _cardNumber = Padding(
      padding: EdgeInsets.only(top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          StreamBuilder<String>(
            stream: bloc.cardNumber,
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? _formatCardNumber(snapshot.data)
                  : _formatCardNumber("0000000000000000");
            },
          )
        ],
      ),
    );

    final _cardLastNumber = Padding(
      padding: EdgeInsets.only(top: 1.0, left: 44.0),
      child: StreamBuilder<String>(
        stream: bloc.cardNumber,
        builder: (context, snapshot) {
          return Text(
            snapshot.hasData && snapshot.data.length >= 15
                ? snapshot.data
                    .replaceAll(RegExp(r'\s+\b|\b\s'), '')
                    .substring(12)
                : "0000",
            style: TextStyle(color: Colors.white, fontSize: 8.0),
          );
        },
      ),
    );

    final _cardValidThru = Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "valid",
                style: TextStyle(color: Colors.white, fontSize: 8.0),
              ),
              Text(
                "thru",
                style: TextStyle(color: Colors.white, fontSize: 8.0),
              )
            ],
          ),
          SizedBox(
            width: 5.0,
          ),
          StreamBuilder(
            stream: bloc.cardMonth,
            builder: (context, snapshot) {
              return Text(
                snapshot.hasData ? snapshot.data : "00",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              );
            },
          ),
          StreamBuilder(
            stream: bloc.cardYear,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Text(
                snapshot.hasData && snapshot.data.length > 2
                    ? "/${snapshot.data.substring(2)}"
                    : "/00",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              );
            },
          ),
        ],
      ),
    );

    final _cardOwner = Padding(
      padding: EdgeInsets.only(top: 15.0, left: 44.0),
      child: StreamBuilder(
        stream: bloc.cardHolderName,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Text(snapshot?.data ?? "CARDHOLDER NAME",
              style: TextStyle(color: Colors.white, fontSize: 18.0));
        },
      ),
    );

    final _cardLogo = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 25.0, right: 45.0),
          child: Image(
            image: AssetImage("assets/images/visa_logo.png"),
            width: 65,
            height: 32.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 45.0),
          child: StreamBuilder(
            stream: bloc.cardType,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Text(
                snapshot.hasData ? snapshot.data : "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400),
              );
            },
          ),
        )
      ],
    );

    return StreamBuilder(
      stream: bloc.cardColorIndexSelected,
      initialData: 0,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: CardColor.baseColors[snapshot.data]),
          child: RotatedBox(
            quarterTurns: rotatedTurnsValue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _cardLogo,
                CardChip(),
                _cardNumber,
                _cardLastNumber,
                _cardValidThru,
                _cardOwner
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _formatCardNumber(String cardNumber) {
    cardNumber = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    List<Widget> numberList = List<Widget>();
    var counter = 0;
    for (var i = 0; i < cardNumber.length; i++) {
      counter += 1;
      numberList.add(Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.0),
        child: Text(
          cardNumber[i],
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ));
      if (counter == 4) {
        counter = 0;
        numberList.add(SizedBox(
          width: 26.0,
        ));
      }
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: numberList);
  }
}
