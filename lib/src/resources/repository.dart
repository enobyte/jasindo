import 'dart:async';

import 'package:jasindo_app/src/models/adcps/do_registration.dart';
import 'package:jasindo_app/src/models/forgotPass.dart';
import 'package:jasindo_app/src/resources/jasindo_api_provider.dart';

import '../models/item_model.dart';

class Repository {
  final jasindoApiProvider = JasindoApiProvider();

  Future<ItemModel> fetchAllMovies() => jasindoApiProvider.fetchMovieList();

  Future<DoRegistrationModel> fetchRegistraion({Map<String, dynamic> body}) =>
      jasindoApiProvider.fetchDoRegister(body: body);

  Future<ForgotPassModels> actForgotPass({Map<String, dynamic> body}) =>
      jasindoApiProvider.forgotPass(body: body);
}
