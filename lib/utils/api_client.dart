import 'dart:async';
import 'dart:convert';
import 'dart:io';
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

  Future<List<Quote>> loadQuote() async {
    var url =
        new Uri.http(baseUrl, 'jy_task/price/quote', {"productNoArray": "ALL"});

    return _getJson(url).then(
        (json) => json.map<Quote>((item) => new Quote.fromJson(item)).toList());
  }
}
