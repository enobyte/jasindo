import 'dart:convert';

import 'package:jasindo_app/src/models/adcps/do_registration.dart';
import 'package:jasindo_app/src/models/adcps/get_plans.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:jasindo_app/utility/sharedpreferences.dart';
import 'package:rxdart/rxdart.dart';

class GetPlansBloc {
  final _repository = Repository();
  final _getPlanFetch = PublishSubject<GetPlansModel>();

  Observable<GetPlansModel> get getPlans => _getPlanFetch.stream;

  fetchGetPlans(Map<String, dynamic> body, Function callback) async {
    GetPlansModel model = await _repository.fetchPlans(body: body);
    if (model.data != null) {
      SharedPreferencesHelper.setPlans(json.encode(model.toJson()));
    }
    callback(model.status, model.message);
  }

  dispose() {
    _getPlanFetch.close();
  }
}

final bloc = GetPlansBloc();
