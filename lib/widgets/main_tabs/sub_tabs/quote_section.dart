import 'package:flutter/material.dart';
import 'package:flutter_xftz/model/price_quote.dart';
import 'package:flutter_xftz/widgets/main_tabs/sub_tabs/quote_card.dart';


class QuoteSection extends StatelessWidget {

  final List<Quote> _quote;
  TickerProvider vsync;

  QuoteSection(this._quote,{this.vsync});

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text("自选行情", ),
        new Container(height: 8.0,),
        new Container(
          height: 140.0,
          child: new ListView(
            scrollDirection: Axis.horizontal,
            children: _quote.map((Quote quote) =>
            new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: new QutoeCard(quote,vsync: vsync,),
            )
            ).toList(),
          ),
        )
      ],
    );
  }

}
