import 'dart:convert';

import 'package:jasindo_app/src/models/adcps/members_model.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:rxdart/rxdart.dart';

class DoRegistrationBloc {
  final _repository = Repository();
  final _doRegistrationFetch = PublishSubject<MemberModels>();

  Observable<MemberModels> get doRegistration => _doRegistrationFetch.stream;

  fetchDoRegistration(Map<String, dynamic> body, Function callback) async {
    MemberModels model = await _repository.fetchRegistraion(body: body);
    SharedPreferencesHelper.setMember(json.encode(model.toJson()));
    callback(model.status, model.message);
  }

  dispose() {
    _doRegistrationFetch.close();
  }
}

final bloc = DoRegistrationBloc();
