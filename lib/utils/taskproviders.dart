import 'dart:async';

import 'package:flutter_xftz/model/news_live.dart';
import 'package:flutter_xftz/model/price_quote.dart';
import 'package:flutter_xftz/utils/api_client.dart';


abstract class TaskProvider {

  Future<List<Quote>> loadQuote();
  Future<List<NewsLive>> loadLiveNews();

}

class PriceTaskProvider extends TaskProvider {

  PriceTaskProvider();

  ApiClient _apiClient = ApiClient.get();

  @override
  Future<List<Quote>> loadQuote() {
    return _apiClient.loadQuote();
  }

  @override
  Future<List<NewsLive>> loadLiveNews() {
    return _apiClient.loadLiveNews();
  }

}



