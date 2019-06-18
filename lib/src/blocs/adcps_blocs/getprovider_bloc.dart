import 'package:jasindo_app/src/models/adcps/get_benefit.dart';
import 'package:jasindo_app/src/models/adcps/get_provider.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetProviderBloc {
  final _repository = Repository();
  final _getProvidertFetch = PublishSubject<GetProviderModel>();

  Observable<GetProviderModel> get getProvier => _getProvidertFetch.stream;

  fetchProvider(Map<String, dynamic> body,
      Function(GetProviderModel, bool, String) callback) async {
    GetProviderModel model = await _repository.fetchProvider(body: body);
    _getProvidertFetch.sink.add(model);
    callback(model, model.status, model.message);
  }

  dispose() {
    _getProvidertFetch.close();
  }
}

final bloc = GetProviderBloc();
