import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiConfig {
  static const String baseUrl = 'https://mobile-flutter-backend.vercel.app/';

  static String get apiBaseUrl => '${baseUrl}api';
  static const int _timeoutLimit = 50;

  Future<dynamic> get({required String endpoint, String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'authorization': 'Bearer $token'});
    }

    http.Response response = await http
        .get(
          Uri.parse('$baseUrl$endpoint'),
          headers: headers,
        )
        .timeout(const Duration(seconds: _timeoutLimit));

    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return responseData;
    } else {
      throw Exception('${responseData['message']}');
    }
  }

  Future<dynamic> post({
    required String endpoint,
    required Map<String, dynamic> body,
    String? token,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers.addAll({'authorization': 'Bearer $token'});
    }

    // print(headers.toString());
    // print(body);
    try {
      http.Response response = await http
          .post(Uri.parse('$baseUrl$endpoint'),
              body: jsonEncode(body), headers: headers)
          .timeout(
            const Duration(seconds: _timeoutLimit),
          );

      Map<String, dynamic> responseData = jsonDecode(response.body);
      if (![200, 201].contains(response.statusCode)) {
        // Request failed with error message
        throw responseData["message"];
      }
      // Successful request
      return responseData;
    } catch (error) {
      // Request failed due to an error
      rethrow;
    }
  }

  Future<dynamic> put({
    required String endpoint,
    @required body,
    @required String? token,
  }) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'authorization': 'Bearer $token'});
    }
    http.Response response = await http.put(Uri.parse('$baseUrl/$endpoint'),
        body: body, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'there is problem with status code: ${response.statusCode}\n with body: ${jsonDecode(response.body)}');
    }
  }
}
