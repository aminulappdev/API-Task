import 'dart:convert';

import 'package:api_task/Data/Models/network_response.dart';
import 'package:api_task/UI/Controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Authorization': 'Bearer ${AuthController.accessToken!.toString()}'
      };

      final Response response = await get(uri, headers: headers);
      debugPrintRequest(url, null, headers);
      debugPrintResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodeData);
      } else if (response.statusCode == 401) {
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            errorMessage: 'Unauthenticated');
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest(
      String url, Map<String, dynamic>? body) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',   
      };

      debugPrintRequest(url, body, headers);
      final Response response =
          await post(uri, headers: headers, body: jsonEncode(body));
      debugPrintResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodeData);
      } else if (response.statusCode == 401) {
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            errorMessage: 'Unauthenticated');
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static void debugPrintRequest(
    String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  ) {
    debugPrint('Request\nURL : $url\nBODY : $body\nHEADERS : $headers');
  }

  static void debugPrintResponse(String url, Response response) {
    debugPrint(
      'URL : $url\nRESPONSE CODE: ${response.statusCode}\nBODY : ${response.body}',
    );
  }
}
