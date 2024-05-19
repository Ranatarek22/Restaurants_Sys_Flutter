import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiConfig {
  final String baseUrl = 'https://mobile-flutter-backend.vercel.app/';

  Future<dynamic> get({required String endpoint}) async {
    http.Response response = await http.get(Uri.parse('$baseUrl$endpoint'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'there is problem with status code ${response.statusCode}');
    }
  }

  Future<dynamic> post(
      {required String endpoint,
      @required body,
      @required String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'authorization': 'Bearer$token'});
    }
    http.Response response = await http.post(Uri.parse('$baseUrl/$endpoint'),
        body: body, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception(
          'there is problem with status code: ${response.statusCode}\n with body: ${jsonDecode(response.body)}');
    }
  }

  Future<dynamic> put(
      {required String endpoint,
      @required body,
      @required String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'authorization': 'Bearer$token'});
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
