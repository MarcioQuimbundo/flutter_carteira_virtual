import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_wallet/src/blocs/card_bloc.dart';
import 'package:flutter_card_wallet/src/models/card_color_model.dart';
import 'package:flutter_card_wallet/src/ui/pages/card_wallet_page.dart';
import 'package:flutter_card_wallet/src/ui/widgets/card_back.dart';
import 'package:flutter_card_wallet/src/ui/widgets/card_front.dart';
import 'package:flutter_card_wallet/src/ui/widgets/flip_card.dart';
import 'package:flutter_card_wallet/src/ui/widgets/my_appbar.dart';
import 'package:flutter_card_wallet/src/utils/card_color.dart';
import 'package:flutter_card_wallet/src/utils/formatters.dart';

class CardCreatePage extends StatefulWidget {
  _CardCreatePageState createState() => _CardCreatePageState();
}

class _CardCreatePageState extends State<CardCreatePage> {
  final GlobalKey<FlipCardState> animatedStateKey = GlobalKey<FlipCardState>();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(_focusNodeListener);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener);
    super.dispose();
  }

  Future<Null> _focusNodeListener() async {
    animatedStateKey.currentState.toggleCard();
  }

  @override
  Widget build(BuildContext context) {
    final CardBloc bloc = BlocProvider.of<CardBloc>(context);

    final _creditCard = Padding(
      padding: EdgeInsets.only(top: 6.0),
      child: Card(
        color: Colors.grey[100],
        elevation: 0.0,
        margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
        child: FlipCard(
          key: animatedStateKey,
          front: CardFront(
            rotatedTurnsValue: 0,
          ),
          back: CardBack(),
        ),
      ),
    );
    final _cardHolderName = StreamBuilder(
      stream: bloc.cardHolderName,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: bloc.changeCardHolderName,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: "Cardholder Name",
              errorText: snapshot.error),
        );
      },
    );
    final _cardNumber = Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: StreamBuilder(
          stream: bloc.cardNumber,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return TextField(
              onChanged: bloc.changeCardCardNumber,
              keyboardType: TextInputType.number,
              maxLength: 19,
              maxLengthEnforced: true,
              inputFormatters: [
                MaskedTextInputFormatter(
                    mask: 'xxxx xxxx xxxx xxxx', separator: " "),
              ],
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Card Number",
                  counterText: "",
                  errorText: snapshot.error),
            );
          },
        ));

    final _cardMonth = StreamBuilder(
      stream: bloc.cardMonth,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          width: 85.0,
          child: TextField(
            onChanged: bloc.changeCardMonth,
            keyboardType: TextInputType.number,
            maxLength: 2,
            maxLengthEnforced: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                hintText: "MM",
                counterText: "",
                errorText: snapshot.error),
          ),
        );
      },
    );

    final _cardYear = StreamBuilder(
      stream: bloc.cardYear,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          width: 120.0,
          child: TextField(
            onChanged: bloc.changeCardYear,
            keyboardType: TextInputType.number,
            maxLength: 4,
            maxLengthEnforced: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                hintText: "YYYY",
                counterText: "",
                errorText: snapshot.error),
          ),
        );
      },
    );

    final _cardVerificationValue = StreamBuilder(
      stream: bloc.cardCvv,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          width: 85.0,
          child: TextField(
            focusNode: _focusNode,
            onChanged: bloc.changeCardCvv,
            keyboardType: TextInputType.number,
            maxLength: 3,
            maxLengthEnforced: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                counterText: "",
                hintText: "CVV",
                errorText: snapshot.error),
          ),
        );
      },
    );

    final _saveCard = StreamBuilder(
      stream: bloc.savecardValid,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          width: MediaQuery.of(context).size.width - 40,
          child: RaisedButton(
            child: Text(
              "Save Card",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.lightBlue,
            onPressed: snapshot.hasData
                ? () {
                    var blocProviderCardWallet = BlocProvider(
                        bloc: bloc, child: CardWallet(),
                        );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => blocProviderCardWallet));
                  }
                : null,
          ),
        );
      },
    );

    return Scaffold(
      appBar: MyAppBar(
        appBarTitle: "Create Card",
        leadingIcon: Icons.arrow_back,
        context: context,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        itemExtent: 750,
        padding: EdgeInsets.only(top: 10.0),
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: _creditCard,
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 8.0,
                      ),
                      _cardHolderName,
                      _cardNumber,
                      SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: <Widget>[
                          _cardMonth,
                          SizedBox(
                            width: 16.0,
                          ),
                          _cardYear,
                          SizedBox(
                            width: 16.0,
                          ),
                          _cardVerificationValue
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      cardColors(bloc),
                      SizedBox(
                        height: 50,
                      ),
                      _saveCard
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget cardColors(CardBloc bloc) {
    final dotSize =
        (MediaQuery.of(context).size.width - 220) / CardColor.baseColors.length;

    List<Widget> dotList = List<Widget>();

    for (var i = 0; i < CardColor.baseColors.length; i++) {
      dotList.add(
        StreamBuilder<List<CardColorModel>>(
          stream: bloc.cardColorList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () => bloc.selectedCardColor(i),
                child: Container(
                  child: snapshot.hasData
                      ? snapshot.data[i].isSelected
                          ? Icon(Icons.check, color: Colors.white, size: 12.0)
                          : Container()
                      : Container(),
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                      color: CardColor.baseColors[i], shape: BoxShape.circle),
                ),
              ),
            );
          },
        ),
      );
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: dotList);
  }
}
