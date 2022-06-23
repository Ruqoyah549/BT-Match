import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bt_match/utils/constants.dart';
import 'package:http/http.dart' as http;

import 'app_exception.dart';

class BaseClient {
  static const int TIME_OUT_DURATION = 20;

  final headers = {"X-Auth-Token": API_KEY};

  //GET
  Future<dynamic> get(String endpoint) async {
    var uri = Uri.parse(BASE_URL + endpoint);
    try {
      var response = await http
          .get(uri, headers: headers)
          .timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response;
      case 201:
        return response;
      case 400:
        throw BadRequestException('${jsonDecode(response.body)["message"]}',
            response.request!.url.toString());
      case 401:
      case 403:
      case 404:
        throw UnAuthorizedException('${jsonDecode(response.body)["message"]}',
            response.request!.url.toString());
      case 422:
        throw BadRequestException('${jsonDecode(response.body)["message"]}',
            response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException('${jsonDecode(response.body)["message"]}',
            response.request!.url.toString());
    }
  }
}
