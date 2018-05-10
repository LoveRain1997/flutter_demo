import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_xftz/model/news_live.dart';
import 'package:flutter_xftz/model/price_quote.dart';

class ApiClient {
  static final _client = new ApiClient._internal();
  final _http = new HttpClient();

  ApiClient._internal();

  final String baseUrl = 'task.xgtz275.com';

  static ApiClient get() {
    return _client;
  }

  Future<dynamic> _getJson(Uri uri) async {
    var response = await (await _http.getUrl(uri)).close();
    var transformedResponse = await response.transform(utf8.decoder).join();
    return json.decode(transformedResponse);
  }


  Future<dynamic> _getTestJson(String temp) async {
    return json.decode(temp);
  }

  Future<List<Quote>> loadQuote() async {
    var url =
        new Uri.http(baseUrl, 'jy_task/price/quote', {"productNoArray": "ALL"});
    return _getJson(url).then(
        (json) => json.map<Quote>((item) =>  Quote.fromJson(item)).toList());
  }

  Future<List<NewsLive>> loadLiveNews() {

    String temp="[{\"name\":\"Michael\",\"context\":\"Jerry\"},{\"name\":\"Michael\",\"context\":\"Jerry\"},{\"name\":\"Michael\",\"context\":\"Jerry\"},{\"name\":\"Michael\",\"context\":\"Jerry\"}]";
    return _getTestJson(temp).then(
            (json) => json.map<NewsLive>((item) =>  NewsLive.fromJson(item)).toList());
  }
}
