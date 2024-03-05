import 'dart:convert';

import 'package:pretty_http_logger/pretty_http_logger.dart';

class ApiClient {
  final String _baseUrl;

  ApiClient(this._baseUrl);

  final HttpWithMiddleware _httpClient = HttpWithMiddleware.build(
    middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ],
  );

  /// post API
  Future<dynamic> post(String endPoint, {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$_baseUrl/$endPoint');
    final headers = {
      'Content-Type': 'application/json',
      "Access-Control_Allow_Origin": "*",
      "Access-Control-Allow-Methods": "POST, HEAD"
    };
    final encodedBody = jsonEncode(body);
    try {
      final response =
          await _httpClient.post(url, headers: headers, body: encodedBody);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 402) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 500) {
        return jsonDecode(response.body);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  /// get API
  Future<dynamic> get({required String endPoint}) async {
    final url = Uri.parse('$_baseUrl/$endPoint');
    final headers = {
      'Content-Type': 'application/json',
      "Access-Control_Allow_Origin": "*",
      "Access-Control-Allow-Methods": "POST, HEAD"
    };
    try {
      final response = await _httpClient.get(url, headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 402) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 500) {
        return jsonDecode(response.body);
      }
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
