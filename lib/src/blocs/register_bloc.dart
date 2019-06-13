import 'dart:convert';

import 'package:jasindo_app/src/models/members_model.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:rxdart/rxdart.dart';

class DoRegisterBloc {
  final _repository = Repository();
  final _doRegistration = PublishSubject<MemberModels>();

  fetchDoRegisterInternal(Map<String, dynamic> body, Function callback) async {
    MemberModels model = await _repository.actRegister(body: body);
    if (model.data != null) {
      SharedPreferencesHelper.setDoLogin(json.encode(model.toJson()));
      SharedPreferencesHelper.setToken(model.data.token);
    }
    callback(model.status, model.message);
  }

  dispose() {
    _doRegistration.close();
  }
}

final bloc = DoRegisterBloc();
