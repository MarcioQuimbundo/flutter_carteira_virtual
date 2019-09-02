import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_card_wallet/src/utils/card_color.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_card_wallet/src/models/card_model.dart';
import 'dart:convert';

class CardListBloc extends BlocBase {
  BehaviorSubject<List<CardResults>> _cardsCollection =
      BehaviorSubject<List<CardResults>>();
  List<CardResults> _cardResults;

  //retrieve data from stream
  Stream<List<CardResults>> get cardList => _cardsCollection.stream;



  void initialData() async {
    var initialData =
        await rootBundle.loadString("assets/data/initialData.json");
    var decodedJson = jsonDecode(initialData);
    _cardResults = CardModel.fromJson(decodedJson).results;
    for (var i = 0; i < _cardResults.length; i++) {
      _cardResults[i].cardColor = CardColor.baseColors[i];
    }
    _cardsCollection.sink.add(_cardResults);
  }

  CardListBloc() {
    initialData();
  }

  void addCardToList(CardResults newCard) {
    _cardResults.add(newCard);
    _cardsCollection.sink.add(_cardResults);
  }

  @override
  void dispose() {
    _cardsCollection.close();
  }
}

final cardListBloc = CardListBloc();
