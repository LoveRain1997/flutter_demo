import 'dart:async';

import 'package:flutter_xftz/model/price_quote.dart';
import 'package:flutter_xftz/utils/api_client.dart';


abstract class TaskProvider {

  Future<List<Quote>> loadQuote();

}

class PriceTaskProvider extends TaskProvider {

  PriceTaskProvider();

  ApiClient _apiClient = ApiClient.get();

  @override
  Future<List<Quote>> loadQuote() {
    return _apiClient.loadQuote();
  }

}



