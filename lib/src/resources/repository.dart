import 'dart:async';

import 'package:jasindo_app/src/models/adcps/do_registration.dart';
import 'package:jasindo_app/src/models/adcps/get_benefit.dart';
import 'package:jasindo_app/src/models/adcps/get_hist_claim.dart';
import 'package:jasindo_app/src/models/adcps/get_plans.dart';
import 'package:jasindo_app/src/models/adcps/get_provider.dart';
import 'package:jasindo_app/src/models/standart_model.dart';
import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/src/resources/jasindo_api_provider.dart';

import '../models/item_model.dart';

class Repository {
  final jasindoApiProvider = JasindoApiProvider();

  Future<ItemModel> fetchAllMovies() => jasindoApiProvider.fetchMovieList();

  Future<DoRegistrationModel> fetchRegistration({Map<String, dynamic> body}) =>
      jasindoApiProvider.fetchDoRegister(body: body);

  Future<GetPlansModel> fetchPlans({Map<String, dynamic> body}) =>
      jasindoApiProvider.fetchGetPlans(body: body);

  Future<GetBenefitModel> fetchBenefit({Map<String, dynamic> body}) =>
      jasindoApiProvider.fetchGetBenefit(body: body);

  Future<GetProviderModel> fetchProvider({Map<String, dynamic> body}) =>
      jasindoApiProvider.fetchGetProvider(body: body);

  Future<GetHistClaimModel> fetchHistClaim({Map<String, dynamic> body}) =>
      jasindoApiProvider.fetchGetHistClaim(body: body);

  Future<MemberModels> actLogin({Map<String, dynamic> body}) =>
      jasindoApiProvider.login(body: body);

  Future<MemberModels> actRegister({Map<String, dynamic> body}) =>
      jasindoApiProvider.register(body: body);

  Future<StandartModels> actForgotPass({Map<String, dynamic> body}) =>
      jasindoApiProvider.forgotPass(body: body);

  Future<StandartModels> actActiveUser({Map<String, dynamic> body}) =>
      jasindoApiProvider.activeUser(body: body);

  Future<StandartModels> actChangePassUser({Map<String, dynamic> body}) =>
      jasindoApiProvider.changePass(body: body);
}
