import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:jasindo_app/src/appConfig.dart';
import 'package:jasindo_app/src/models/adcps/do_registration.dart';
import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';

import '../models/item_model.dart';

class JasindoApiProvider {
  Client client = Client();
  final _apiKey = '802b2c4b88ea1183e50e6b285a27696e';
  String _baseUrl = AppConfig.baseUrl;

  Future<ItemModel> fetchMovieList() async {
    final response = await client.get("$_baseUrl/popular?api_key=$_apiKey");
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<DoRegistrationModel> fetchDoRegister(
      {Map<String, dynamic> body}) async {
    final response = await client.post(
      "$_baseUrl/member/adcps_login",
      body: json.encode(body),
      headers: {
        "Authorization": SharedPreferencesHelper.getToken().toString(),
      },
    );
    if (response.statusCode == 200) {
      return DoRegistrationModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load doRegistration');
    }
  }

//  Future<TrailerModel> fetchTrailer(int movieId) async {
//    final response =
//        await client.get("$_baseUrl/$movieId/videos?api_key=$_apiKey");
//
//    if (response.statusCode == 200) {
//      return TrailerModel.fromJson(json.decode(response.body));
//    } else {
//      throw Exception('Failed to load trailers');
//    }
//  }
}
