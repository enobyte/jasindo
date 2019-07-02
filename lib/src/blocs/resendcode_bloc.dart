import 'package:jasindo_app/src/models/standart_model.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ResendCodeBloc {
  final _repository = Repository();
  final _resendCode = PublishSubject<StandartModels>();

  actResendCode(Map<String, dynamic> body, Function callback) async {
    StandartModels model = await _repository.resendCode(body: body);
    callback(model.status, model.message);
  }

  dispose() {
    _resendCode.close();
  }
}

final bloc = ResendCodeBloc();
