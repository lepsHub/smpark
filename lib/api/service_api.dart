import 'dart:convert';

import 'package:http/http.dart';
import 'package:smpark/src/providers/list_provider.dart';

part 'package:smpark/api/service_util.dart';

class ServiceConstants {
  static const String BASE_URL = "localhost:8080";

  static const String SERVICE_BY_COLLAB_PATH = "api/estacionamientos/";
}

class ServiceAPI {
  const ServiceAPI();

  Future<T> consumeGet<T>(String url) async {
    try {
      Uri uri = Uri.http(ServiceConstants.BASE_URL, url);
      print("Request => ${uri.toString()};");
      final response = await get(uri, headers: ServiceUtil.createHeaders(""));
      print("Response => Code: ${uri.toString()}; ${response.statusCode}");
      return ServiceUtil.returnResponse(response);
    } catch (e) {
      print("An error has occurred ${e.runtimeType} -> ${e.toString()}");
      throw e;
    }
  }

  Future<T> consumePost<T>(String url, String body) async {
    try {
      Uri uri = Uri.http(ServiceConstants.BASE_URL, url);
      print("Request => ${uri.toString()};");
      final response =
          await post(uri, headers: ServiceUtil.createHeaders(""), body: body);
      print("Response => ${uri.toString()}; Code: ${response.statusCode};");
      return ServiceUtil.returnResponse<T>(response);
    } catch (e) {
      print("An error has occurred ${e.runtimeType} -> ${e.toString()}");
      throw e;
    }
  }
}
