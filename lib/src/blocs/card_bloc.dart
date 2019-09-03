import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_card_wallet/src/blocs/card_list_bloc.dart';
import 'package:flutter_card_wallet/src/models/card_color_model.dart';
import 'package:flutter_card_wallet/src/models/card_model.dart';
import 'package:flutter_card_wallet/src/utils/card_color.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_card_wallet/src/utils/validators.dart';

class CardBloc with Validators implements BlocBase {
  BehaviorSubject<String> _cardHolderName = BehaviorSubject<String>();
  BehaviorSubject<String> _cardNumber = BehaviorSubject<String>();
  BehaviorSubject<String> _cardMonth = BehaviorSubject<String>();
  BehaviorSubject<String> _cardYear = BehaviorSubject<String>();
  BehaviorSubject<String> _cardCvv = BehaviorSubject<String>();
  BehaviorSubject<String> _cardType = BehaviorSubject<String>();
  BehaviorSubject<int> _cardColorIndexSelected =
      BehaviorSubject<int>(seedValue: 0);

  final _cardsColors = BehaviorSubject<List<CardColorModel>>();

  //add data stream
  Function(String) get changeCardHolderName => _cardHolderName.sink.add;
  Function(String) get changeCardCardNumber => _cardNumber.sink.add;
  Function(String) get changeCardMonth => _cardMonth.sink.add;
  Function(String) get changeCardYear => _cardYear.sink.add;
  Function(String) get changeCardCvv => _cardCvv.sink.add;
  Function(String) get selectCardType => _cardType.sink.add;
  Stream<List<CardColorModel>> get cardColorList => _cardsColors.stream;
  Stream<bool> get savecardValid => Observable.combineLatest5(cardHolderName,
      cardNumber, cardMonth, cardYear, cardCvv, (ch, cn, cm, cy, cv) => true);

  //retrieve data from stream
  Stream<String> get cardHolderName =>
      _cardHolderName.stream.transform(validateCardHolderName);
  Stream<String> get cardNumber =>
      _cardNumber.stream.transform(validateCardNumber);
  Stream<String> get cardMonth => _cardMonth.stream.transform(validateCardMonth);
  Stream<String> get cardYear => _cardYear.stream.transform(validateCardYear);
  Stream<String> get cardCvv =>
      _cardCvv.stream.transform(validateCardVerificationValue);
  Stream<String> get cardType => _cardType.stream;
  Stream<int> get cardColorIndexSelected => _cardColorIndexSelected.stream;
  void saveCard() {
    final newCard = CardResults(
        cardHolderName: _cardHolderName.value,
        cardNumber: _cardNumber.value.replaceAll(RegExp(r'\s+\b|\b\s'), ''),
        cardMonth: _cardMonth.value,
        cardYear: _cardYear.value,
        cardCvv: _cardCvv.value,
        cardColor: CardColor.baseColors[_cardColorIndexSelected.value],
        cardType: _cardType.value);
    cardListBloc.addCardToList(newCard);
  }

  void selectedCardColor(int colorIndex) {
    CardColor.cardColors.forEach((element) => element.isSelected = false);
    CardColor.cardColors[colorIndex].isSelected = true;
    _cardsColors.sink.add(CardColor.cardColors);
    _cardColorIndexSelected.sink.add(colorIndex);
  }

  @override
  void dispose() {
    _cardHolderName.close();
    _cardNumber.close();
    _cardMonth.close();
    _cardYear.close();
    _cardCvv.close();
    _cardType.close();
    _cardColorIndexSelected.close();
    _cardsColors.close();
  }
}
