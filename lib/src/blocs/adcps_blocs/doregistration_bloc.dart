import 'dart:convert';

import 'package:jasindo_app/src/models/adcps/do_registration.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:rxdart/rxdart.dart';

class DoRegistrationBloc {
  final _repository = Repository();
  final _doRegistrationFetch = PublishSubject<DoRegistrationModel>();

  Observable<DoRegistrationModel> get doRegistration =>
      _doRegistrationFetch.stream;

  fetchDoRegistration(Map<String, dynamic> body, Function callback) async {
    DoRegistrationModel model = await _repository.fetchRegistration(body: body);
    if (model.data != null) {
      SharedPreferencesHelper.setDoRegistration(json.encode(model.toJson()));
    }
    callback(model.status, model.message);
  }

  dispose() {
    _doRegistrationFetch.close();
  }
}

final bloc = DoRegistrationBloc();
