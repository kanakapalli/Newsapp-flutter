
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class GettopheadingCall {
  static Future<ApiCallResponse> call({
    String country = 'us',
    String apikey = 'cf7a6c505b424f7eb515920125ff7a51',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'gettopheading',
      apiUrl:
          'https://newsapi.org/v2/top-headlines?country=${country}&apiKey=${apikey}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}

class GeteverthingCall {
  static Future<ApiCallResponse> call({
    String search = 'bitcoin',
    String apikey = 'cf7a6c505b424f7eb515920125ff7a51',
  }) {
    return ApiManager.instance.makeApiCall(
      callName: 'geteverthing',
      apiUrl: 'https://newsapi.org/v2/everything?q=${search}&apiKey=${apikey}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
    );
  }
}
