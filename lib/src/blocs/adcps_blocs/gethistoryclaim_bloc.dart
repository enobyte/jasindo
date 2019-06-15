import 'package:jasindo_app/src/models/adcps/get_hist_claim.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetHistoryClaimBloc {
  final _repository = Repository();
  final _getHistClaimFetch = PublishSubject<GetHistClaimModel>();

  Observable<GetHistClaimModel> get getHistClaim => _getHistClaimFetch.stream;

  fetchHistClaim(
      Map<String, dynamic> body,
      Function(GetHistClaimModel, bool status, String message)
          callback) async {
    GetHistClaimModel model = await _repository.fetchHistClaim(body: body);

    _getHistClaimFetch.sink.add(model);

    callback(model, model.status, model.message);
  }

  dispose() {
    _getHistClaimFetch.close();
  }
}

final bloc = GetHistoryClaimBloc();
