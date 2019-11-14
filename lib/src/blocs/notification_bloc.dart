import 'package:jasindo_app/src/models/btndischarge_model.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class DischargeBloc {
  final _repository = Repository();
  final _notifBloc = BehaviorSubject<Map<String, dynamic>>();

  Observable<Map<String, dynamic>> get getNotifBloc => _notifBloc.stream;

  notifDischargeBloc(Map<String, dynamic> data) {
    _notifBloc.sink.add(data);
  }

  buttonDischargeBloc(String cardNumb) async {
    BtnDischargeModel model = await _repository.actDischarge(cardNumb);
    if (model != null) {
      _notifBloc.sink.add(model.toJson());
    }
  }

  dispose() {
    _notifBloc.close();
  }
}

final bloc = DischargeBloc();
