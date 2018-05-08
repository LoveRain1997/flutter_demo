import 'package:flutter_xftz/utils/utils.dart';

class Quote {
   String id;
   String settupPrice;
   String tranNum;
   int dealStartTime;
   String latestTime;
   double Ask;
   double LastOpen;
   double LastClose;
   double Max;
   double Min;
   String ProductCode;
   String ProductName;

   double UpsAndDowns; //本地计算涨跌
   double UpsAndDownsRate ;//涨跌率


   Quote.fromJson(Map jsonMap)
      : id = jsonMap['id'],
        settupPrice = jsonMap['settupPrice'],
        tranNum = jsonMap['tranNum'],
        dealStartTime = jsonMap['dealStartTime'],
        latestTime = jsonMap['latestTime'],
        Ask = jsonMap['Ask'],
        Max = jsonMap['Max'],
        Min = jsonMap['Min'],
        ProductCode = jsonMap['ProductCode'],
        ProductName = jsonMap['ProductName'],
        LastOpen = jsonMap['LastOpen'],
        LastClose = jsonMap['LastClose'];
}
