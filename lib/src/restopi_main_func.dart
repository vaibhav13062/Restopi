import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restopi/src/Constants/inner_methods.dart';


import '../restopi.dart';

class Restopi {
  Restopi._();
  Restopi();
  String? _baseUrl;
  bool? _enableLoading;

  static final Restopi instance = Restopi._();

  static set enableLoading(bool value) {
    if (value == instance._baseUrl) {
      return;
    }

    instance._enableLoading = value;
  }

  static bool get enableLoading {
    assert(instance._enableLoading != null,
        ' enableLoading is required and missing');
    return instance._enableLoading!;
  }

  static set baseUrl(String value) {
    if (value == instance._baseUrl) {
      return;
    }
    instance._baseUrl = value;
  }

  static String get baseUrl {
    assert(instance._baseUrl != null, 'A Base Url is required and missing');
    return instance._baseUrl!;
  }

  static TransitionBuilder builderInit({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(context, FlutterEasyLoading(child: child));
      } else {
        return FlutterEasyLoading(child: child);
      }
    };
  }

  void restopiInitialize({
    EasyLoadingIndicatorType? easyLoadingIndicatorType,
    EasyLoadingStyle? easyLoadingStyle,
    double? indicatorSize,
    double? radius,
    Color? progressColors,
    Color? backgroundColor,
    Color? indicatorColor,
    Color? textColor,
    Color? maskColor,
    bool? userInteractions,
    bool? dismissOnTap,
  }) {
    EasyLoading.instance
      ..indicatorType =
          easyLoadingIndicatorType ?? EasyLoadingIndicatorType.dualRing
      ..loadingStyle = easyLoadingStyle ?? EasyLoadingStyle.custom
      ..indicatorSize = indicatorSize ?? 45.0
      ..radius = radius ?? 10.0
      ..progressColor = progressColors ?? Colors.blueAccent
      ..backgroundColor = backgroundColor ?? Colors.white
      ..indicatorColor = indicatorColor ?? Colors.blueAccent
      ..textColor = textColor ?? Colors.black
      ..maskColor = maskColor ?? Colors.lightBlue.withOpacity(0.3)
      ..userInteractions = userInteractions ?? false
      ..dismissOnTap = dismissOnTap ?? false;
  }

  Future<void> hitRestopi(
      {required BuildContext buildContext,
      required RestopiMethods restopiMethod,
      required String urlEndPoint,
      required Map<String, String> headers,
      required Function(Map<String, dynamic>) onFail,
      required Function(Map<String, dynamic>) onSuccess,
      required Function() onConnectionLost,
      Map<String, String>? query,
      Map<String, String>? body,
      bool? showLoading}) async {
    if (baseUrl == null) {
      throw Exception("Base URL Cannot Be Null .");
    }
    if (enableLoading == null) {
      throw Exception("enableLoading Cannot Be Null .");
    }
    if(restopiMethod == RestopiMethods.get){
      if(query==null){
        print("Query is Required in Get Method");
      }
    }
    if(restopiMethod == RestopiMethods.post){
      if(body==null){
        print("Body is Required in Get Method");
      }
    }
    if(restopiMethod == RestopiMethods.put){
      if(body==null){
        print("Body is Required in Put Method");
      }
    }
    if(restopiMethod == RestopiMethods.delete){
      if(body==null){
        print("Body is Required in Delete Method");
      }
    }

    if (kDebugMode) {
      print("API URL ==  ${Uri.https(baseUrl, urlEndPoint)}");
      if (query != null) {
        print("QUERIES == $query");
      }
      if (body != null) {
        print("BODY == $body");
      }
      print("API TYPE ==  $restopiMethod");
      print("HEADERS ==  $headers");
    }

    switch (restopiMethod) {
      case RestopiMethods.get:
        await InnerMethods().get(
            context: buildContext,
            url: urlEndPoint,
            baseUrl: baseUrl,
            onFail: onFail,
            onSuccess: onSuccess,
            onConnectionFailed: onConnectionLost,
            queryParams: query ?? {},
            headers: headers,
            showLoading: enableLoading
                ? showLoading ?? true
                : false);
        break;
      case RestopiMethods.post:
        await InnerMethods().post(
            context: buildContext,
            url: urlEndPoint,
            baseUrl: baseUrl,
            onFail: onFail,
            onSuccess: onSuccess,
            onConnectionFailed: onConnectionLost,
            body: body ?? {},
            queryParams: query,
            headers: headers,
            showLoading: enableLoading
                ? showLoading ?? true
                : false);
        break;
      case RestopiMethods.put:
        await InnerMethods().post(
            context: buildContext,
            url: urlEndPoint,
            baseUrl: baseUrl,
            onFail: onFail,
            onSuccess: onSuccess,
            onConnectionFailed: onConnectionLost,
            body: body ?? {},
            queryParams: query,
            headers: headers,
            showLoading: enableLoading
                ? showLoading ?? true
                : false);
        break;
      case RestopiMethods.delete:
        await InnerMethods().post(
            context: buildContext,
            url: urlEndPoint,
            baseUrl: baseUrl,
            onFail: onFail,
            onSuccess: onSuccess,
            onConnectionFailed: onConnectionLost,
            body: body ?? {},
            queryParams: query,
            headers: headers,
            showLoading: enableLoading
                ? showLoading ?? true
                : false);
        break;
    }
  }
}
