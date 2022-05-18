import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:restopi/src/Models/fail_response.dart';

class InnerMethods {
  Future<void> get(
      {required BuildContext context,
      required String url,
      required String baseUrl,
      required Function(Map<String, dynamic>) onFail,
      required Function(Map<String, dynamic>) onSuccess,
      required Function() onConnectionFailed,
      required Map<String, String> queryParams,
      required Map<String, String> headers,
      required bool showLoading}) async {
    if (showLoading) {
      if (!EasyLoading.isShow) {
        EasyLoading.show(status: "");
      }
    }

    try {
      final response = await http.get(Uri.https(baseUrl, url, queryParams),
          headers: headers);
      _response(response, onFail, onSuccess, showLoading);
    } on SocketException {
      if (showLoading) {
        if (EasyLoading.isShow) {
          EasyLoading.dismiss();
        }
      }
      onConnectionFailed();

      throw Exception("No Internet");
    }
  }

  Future<void> post(
      {required BuildContext context,
      required String url,
      required String baseUrl,
      required Function(Map<String, dynamic>) onFail,
      required Function(Map<String, dynamic>) onSuccess,
      required Function() onConnectionFailed,
      Map<String, String>? queryParams,
      required Map<String, String> body,
      required Map<String, String> headers,
      required bool showLoading}) async {
    if (showLoading) {
      if (!EasyLoading.isShow) {
        EasyLoading.show(status: "");
      }
    }

    try {
      http.Response response;
      if (queryParams == null) {
        response = await http.post(Uri.https(baseUrl, url),
            headers: headers, body: bool);
      } else {
        response = await http.post(Uri.https(baseUrl, url, queryParams),
            headers: headers, body: bool);
      }
      _response(response, onFail, onSuccess, showLoading);
    } on SocketException {
      if (showLoading) {
        if (EasyLoading.isShow) {
          EasyLoading.dismiss();
        }
      }
      onConnectionFailed();

      throw Exception("No Internet");
    }
  }

  Future<void> put(
      {required BuildContext context,
      required String url,
      required String baseUrl,
      required Function(Map<String, dynamic>) onFail,
      required Function(Map<String, dynamic>) onSuccess,
      required Function() onConnectionFailed,
      Map<String, String>? queryParams,
      required Map<String, String> body,
      required Map<String, String> headers,
      required bool showLoading}) async {
    if (showLoading) {
      if (!EasyLoading.isShow) {
        EasyLoading.show(status: "");
      }
    }

    try {
      http.Response response;
      if (queryParams == null) {
        response = await http.put(Uri.https(baseUrl, url),
            headers: headers, body: bool);
      } else {
        response = await http.put(Uri.https(baseUrl, url, queryParams),
            headers: headers, body: bool);
      }
      _response(response, onFail, onSuccess, showLoading);
    } on SocketException {
      if (showLoading) {
        if (EasyLoading.isShow) {
          EasyLoading.dismiss();
        }
      }
      onConnectionFailed();

      throw Exception("No Internet");
    }
  }

  Future<void> delete(
      {required BuildContext context,
      required String url,
      required String baseUrl,
      required Function(Map<String, dynamic>) onFail,
      required Function(Map<String, dynamic>) onSuccess,
      required Function() onConnectionFailed,
      Map<String, String>? queryParams,
      required Map<String, String> body,
      required Map<String, String> headers,
      required bool showLoading}) async {
    if (showLoading) {
      if (!EasyLoading.isShow) {
        EasyLoading.show(status: "");
      }
    }
    try {
      http.Response response;
      if (queryParams == null) {
        response = await http.delete(Uri.https(baseUrl, url),
            headers: headers, body: bool);
      } else {
        response = await http.delete(Uri.https(baseUrl, url, queryParams),
            headers: headers, body: bool);
      }
      _response(response, onFail, onSuccess, showLoading);
    } on SocketException {
      if (showLoading) {
        if (EasyLoading.isShow) {
          EasyLoading.dismiss();
        }
      }
      onConnectionFailed();

      throw Exception("No Internet");
    }
  }

  void _response(http.Response response, Function(Map<String, dynamic>) onFail,
      Function(Map<String, dynamic>) onSuccess, bool showLoading) {
    if (kDebugMode) {
      print("API HIT COMPLETE");
      print("STATUS CODE == ${response.statusCode}");
      print("RESPONSE == ${response.body.toString()}");
    }

    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        if (showLoading) {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
        }
        onSuccess(responseJson);
        break;
      case 201:
      case 202:
      case 203:
        var responseJson = json.decode(response.body.toString());
        if (showLoading) {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
        }
        onSuccess(responseJson);
        break;
      case 400:
        if (EasyLoading.isShow) {
          EasyLoading.dismiss();
        }
        onFail(FailResponse(
                statusCode: response.statusCode, body: response.body.toString())
            .toJson());
        break;
      case 401:
      case 402:
      case 403:
      case 404:
      case 405:
      case 408:
      case 407:
      case 406:
        if (showLoading) {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
        }
        onFail(FailResponse(
                statusCode: response.statusCode, body: response.body.toString())
            .toJson());

        break;

      case 500:
        if (showLoading) {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
        }
        onFail(FailResponse(
            statusCode: response.statusCode,
            body: {"message": "Internal Server Error"}).toJson());
        break;
      case 501:
        if (showLoading) {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
        }
        onFail(FailResponse(
            statusCode: response.statusCode,
            body: {"message": "Not Implemented"}).toJson());
        break;
      case 502:
        if (showLoading) {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
        }
        onFail(FailResponse(
            statusCode: response.statusCode,
            body: {"message": " Bad Gateway"}).toJson());
        break;
      case 503:
        if (showLoading) {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
        }
        onFail(FailResponse(
            statusCode: response.statusCode,
            body: {"message": " Service Unavailable"}).toJson());
        break;
      case 504:
        if (showLoading) {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
        }
        onFail(FailResponse(
            statusCode: response.statusCode,
            body: {"message": "  Gateway Timeout"}).toJson());
        break;
      case 505:
        if (showLoading) {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
        }
        onFail(FailResponse(
            statusCode: response.statusCode,
            body: {"message": " HTTP Version Not Supported "}).toJson());
        break;
      case 507:
        if (showLoading) {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
        }
        onFail(FailResponse(
            statusCode: response.statusCode,
            body: {"message": " Insufficient Storage"}).toJson());
        break;

      default:
        if (showLoading) {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
        }
        onFail(FailResponse(
            statusCode: response.statusCode,
            body: {"message": "Something Went Wrong"}).toJson());
        break;
    }
  }
}
