import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_clean_coding/data/exceptions/app_exception.dart';
import 'package:flutter_clean_coding/data/network/base_api_service.dart';

/// A network service class that implements [BaseApiServices] to handle
/// HTTP GET and POST requests.
class NetworkApiServices implements BaseApiServices {


  @override
  /// Performs a GET request to the given [url].
  ///
  /// Throws [NotInternetException] if there is no internet connection.
  /// Throws [RequestTimeOutException] if the request times out.
  /// Throws [FetchDataException] for other server-related errors.
  Future<dynamic> getData(String url) async {
    dynamic jsonResponse;

    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 50));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NotInternetException('');
    } on TimeoutException {
      throw RequestTimeOutException();
    } on FetchDataException {
      throw FetchDataException("Internal server error");
    }
    return jsonResponse;
  }

  @override
  /// Performs a POST request to the given [url] with the provided [data].
  ///
  /// Includes a hardcoded API key in the headers.
  ///
  /// Throws [NotInternetException] if there is no internet connection.
  /// Throws [RequestTimeOutException] if the request times out.
  /// Throws [FetchDataException] for other server-related errors.
  Future<dynamic> postData(String url, var data) async {
    dynamic jsonResponse;

    if (kDebugMode) {
      print(url);
      print(data);
    }
    try {
      final response = await http.post(Uri.parse(url), body: data,
        headers: {
          'x-api-key': 'reqres-free-v1',
          "Accept": "application/json",
        },
      ).timeout(const Duration(seconds: 50));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NotInternetException('');
    } on TimeoutException {
      throw RequestTimeOutException();
    } on FetchDataException {
      throw FetchDataException("Internal server error");
    }
    if (kDebugMode) {
      print(jsonResponse);
    }
    return jsonResponse;
  }

  /// Processes the [http.Response] and returns the JSON body.
  ///
  /// Handles different HTTP status codes:
  /// - 200, 400: Decodes and returns the JSON response body.
  /// - 401: Throws [UnauthorisedException].
  /// - 500: Throws [FetchDataException].
  /// For any other status code, it returns null.
  dynamic returnResponse(http.Response response) {
    if (kDebugMode) {
      print(response.statusCode);
    }
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 401:
        throw UnauthorisedException('');
      case 500:
        throw FetchDataException('Error while communication');
      default:
        throw FetchDataException('Error occurred while communicating with server with status code ${response.statusCode}');
    }
  }
}