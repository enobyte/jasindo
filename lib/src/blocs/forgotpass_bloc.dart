import 'package:jasindo_app/src/models/standart_model.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPassBloc {
  final _repository = Repository();
  final _forgotPassword = PublishSubject<StandartModels>();

  actForgotPass(Map<String, dynamic> body, Function callback) async {
    StandartModels model = await _repository.actForgotPass(body: body);
    callback(model.status, model.message);
  }

  dispose() {
    _forgotPassword.close();
  }
}

final bloc = ForgotPassBloc();
