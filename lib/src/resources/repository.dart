import 'dart:async';

import 'package:jasindo_app/src/models/adcps/members_model.dart';
import 'package:jasindo_app/src/resources/jasindo_api_provider.dart';

import '../models/item_model.dart';

class Repository {
  final jasindoApiProvider = JasindoApiProvider();

  Future<ItemModel> fetchAllMovies() => jasindoApiProvider.fetchMovieList();

  Future<MemberModels> fetchRegistraion({Map<String, dynamic> body}) =>
      jasindoApiProvider.fetchDoRegister(body: body);
}
