import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class CardBloc extends BlocBase {
  BehaviorSubject<String> _cardType = BehaviorSubject<String>();

  //add data stream
  Function(String) get selectCardType => _cardType.sink.add;

  //retrieve data from stream
  Stream<String> get cardType=>_cardType.stream;

  @override
  void dispose() {
    _cardType.close();
  }
  
}