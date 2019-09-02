import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_wallet/src/blocs/card_bloc.dart';
import 'package:flutter_card_wallet/src/utils/card_color.dart';

class CardBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CardBloc bloc = BlocProvider.of<CardBloc>(context);
    return StreamBuilder(
      stream: bloc.cardColorIndexSelected,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          decoration: BoxDecoration(
            color: snapshot.hasData
                ? CardColor.baseColors[snapshot.data]
                : CardColor.baseColors[0],
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Image(
                        image: AssetImage("assets/images/card_band.jpg"),
                        width: 200.0,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Container(
                      width: 65.0,
                      height: 42.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          border: Border.all(color: Colors.red, width: 3.0),
                          color: Colors.white),
                      child: Center(
                        child: StreamBuilder(
                          stream: bloc.cardCvv,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            return Text(
                              snapshot.hasData ? snapshot.data : "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.0, left: 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      image: AssetImage("assets/images/card_back.jpg"),
                      width: 65,
                      height: 40,
                      fit: BoxFit.fill,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
