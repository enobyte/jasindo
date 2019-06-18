import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:jasindo_app/src/models/adcps/do_registration.dart';
import 'package:jasindo_app/src/models/adcps/get_benefit.dart';
import 'package:jasindo_app/src/models/adcps/get_hist_claim.dart';
import 'package:jasindo_app/src/models/adcps/get_plans.dart';
import 'package:jasindo_app/src/models/adcps/get_provider.dart';
import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/src/models/standart_model.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';

import '../models/item_model.dart';

class JasindoApiProvider {
  Dio _dio;
  final _apiKey = '802b2c4b88ea1183e50e6b285a27696e';
  String _baseUrl = 'http://103.107.103.56:8000/api';

  //String _baseUrl = 'http://169.254.224.69:8000/api';

  ///
  /// Property For Handle Interceptor
  ///

  JasindoApiProvider() {
    SharedPreferencesHelper.getToken().then((token) {
      Options options = Options(
          receiveTimeout: 5000,
          connectTimeout: 5000,
          baseUrl: _baseUrl,
          headers: {'Authorization': token},
          contentType: ContentType.parse("application/json"));

      _dio = Dio(options);
      _setupLoggingInterceptor();
    });
  }

  String _handleError(Error error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              "Received invalid status code: ${error.response.statusCode}";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }

  void _setupLoggingInterceptor() {
    int maxCharactersPerLine = 200;

    _dio.interceptor.request.onSend = (Options options) {
      print("--> ${options.method} ${options.path}");
      print("Header: ${options.headers}");
      print("Content type: ${options.contentType}");
      print("Body: ${options.data}");
      print("<-- END HTTP");
      return options;
    };

    _dio.interceptor.response.onSuccess = (Response response) {
      print(
          "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
      String responseAsString = response.data.toString();
      if (responseAsString.length > maxCharactersPerLine) {
        int iterations =
            (responseAsString.length / maxCharactersPerLine).floor();
        for (int i = 0; i <= iterations; i++) {
          int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
          if (endingIndex > responseAsString.length) {
            endingIndex = responseAsString.length;
          }
          print(responseAsString.substring(
              i * maxCharactersPerLine, endingIndex));
        }
      } else {
        print(response.data);
      }
      print("<-- END HTTP");
    };
  }

  ///
  /// Example
  ///

  Future<ItemModel> fetchMovieList() async {
    try {
      final response = await _dio.get("$_baseUrl/popular?api_key=$_apiKey");
      return ItemModel.fromJson(json.decode(response.data));
    } catch (error, _) {
      throw Exception(_handleError(error));
    }
  }

  ///
  /// API ADCPS HANDLER
  ///
  Future<DoRegistrationModel> fetchDoRegister(
      {Map<String, dynamic> body}) async {
    try {
      final response = await _dio.post("$_baseUrl/member/adcps_login",
          data: json.encode(body));
      return DoRegistrationModel.fromJson(response.data);
    } catch (error, _) {
      return DoRegistrationModel.withError(_handleError(error));
    }
  }

  Future<GetPlansModel> fetchGetPlans({Map<String, dynamic> body}) async {
    try {
      final response = await _dio.post("$_baseUrl/member/adcps_plan",
          data: json.encode(body));
      return GetPlansModel.fromJson(response.data);
    } catch (error, _) {
      return GetPlansModel.withError(_handleError(error));
    }
  }

  Future<GetBenefitModel> fetchGetBenefit({Map<String, dynamic> body}) async {
    try {
      final response = await _dio.post("$_baseUrl/member/adcps_benefit",
          data: json.encode(body));
      return GetBenefitModel.fromJson(response.data);
    } catch (error, _) {
      return GetBenefitModel.withError(_handleError(error));
    }
  }

  Future<GetProviderModel> fetchGetProvider({Map<String, dynamic> body}) async {
    try {
      final response = await _dio.post("$_baseUrl/member/adcps_providers",
          data: json.encode(body));
      return GetProviderModel.fromJson(response.data);
    } catch (error, trace) {
      print(trace.toString());
      return GetProviderModel.withError(_handleError(error));
    }
  }

  Future<GetHistClaimModel> fetchGetHistClaim(
      {Map<String, dynamic> body}) async {
    try {
      final response = await _dio.post("$_baseUrl/member/adcps_histclaim",
          data: json.encode(body));
      return GetHistClaimModel.fromJson(response.data);
    } catch (error, _) {
      return GetHistClaimModel.withError(_handleError(error));
    }
  }

  ///
  /// API INTERNAL HANDLER
  ///
  Future<MemberModels> login({Map<String, dynamic> body}) async {
    try {
      final response =
          await _dio.post("$_baseUrl/member/login", data: json.encode(body));
      return MemberModels.fromJson(response.data);
    } catch (error, _) {
      return MemberModels.withError(_handleError(error));
    }
  }

  Future<MemberModels> register({Map<String, dynamic> body}) async {
    try {
      final response =
          await _dio.post("$_baseUrl/member/create", data: json.encode(body));
      return MemberModels.fromJson(response.data);
    } catch (error, _) {
      return MemberModels.withError(_handleError(error));
    }
  }

  Future<StandartModels> forgotPass({Map<String, dynamic> body}) async {
    try {
      final response = await _dio.post("$_baseUrl/member/preforgotpass",
          data: json.encode(body));
      return StandartModels.fromJson(response.data);
    } catch (error, _) {
      return StandartModels.withError(_handleError(error));
    }
  }

  Future<StandartModels> activeUser({Map<String, dynamic> body}) async {
    try {
      final response = await _dio.post("$_baseUrl/member/activateuser",
          data: json.encode(body));
      return StandartModels.fromJson(response.data);
    } catch (error, _) {
      return StandartModels.withError(_handleError(error));
    }
  }

  Future<StandartModels> changePass({Map<String, dynamic> body}) async {
    try {
      final response = await _dio.post("$_baseUrl/member/changepass",
          data: json.encode(body));
      return StandartModels.fromJson(response.data);
    } catch (error, _) {
      return StandartModels.withError(_handleError(error));
    }
  }
}
