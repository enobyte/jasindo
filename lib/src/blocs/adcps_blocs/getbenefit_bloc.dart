import 'package:jasindo_app/src/models/adcps/get_benefit.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetBenefitBloc {
  final _repository = Repository();
  final _getBeneiftFetch = PublishSubject<GetBenefitModel>();

  Observable<GetBenefitModel> get getBenefit => _getBeneiftFetch.stream;

  fetchBenefit(Map<String, dynamic> body) async {
    GetBenefitModel model = await _repository.fetchBenefit(body: body);
    _getBeneiftFetch.sink.add(model);
  }

  dispose() {
    _getBeneiftFetch.close();
  }
}

final bloc = GetBenefitBloc();
