import 'package:jasindo_app/src/models/adcps/get_benefit.dart';
import 'package:jasindo_app/src/models/adcps/get_provider.dart';
import 'package:jasindo_app/src/models/dependent_model.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetDependentBloc {
  final _repository = Repository();
  final _getDependentFetch = PublishSubject<DependentModels>();

  Observable<DependentModels> get getDependent => _getDependentFetch.stream;

  fetchDependent(
      Map<String, dynamic> body, Function(DependentModels, bool, String) callback) async {
    DependentModels model = await _repository.fetchDependent(body: body);
    _getDependentFetch.sink.add(model);
    callback(model, model.status, model.message);
  }

  dispose() {
    _getDependentFetch.close();
  }
}

final bloc = GetDependentBloc();
