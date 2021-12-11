part of 'service_api.dart';

String EMPTY_STRING = "";

class ServiceUtil {
  static T returnResponse<T>(Response response) { 
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        if (T == ObjectParkWrapper)
          return ObjectParkWrapper.fromJson(responseJson) as T;
        else if (T == SearchResultWrapper)
          return SearchResultWrapper.fromJson(responseJson) as T;

        throw Exception(response.request?.url.toString() ?? EMPTY_STRING);
      default:
        throw Exception(response.request?.url.toString() ?? EMPTY_STRING);
    }
  }

  static Map<String, String> createHeaders(String authToken) {
    return {
      "Content-Type": "application/json; charset=UTF-8",
      "authentication": "Bearer $authToken",
      "Access-Control-Allow-Origin": "*"
    };
  }
}
