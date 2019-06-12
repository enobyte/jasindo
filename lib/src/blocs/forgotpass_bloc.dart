import 'package:jasindo_app/src/models/forgotPass.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ForgotPassBloc {
  final _repository = Repository();
  final _forgotPassword = PublishSubject<ForgotPassModels>();

  actForgotPass(Map<String, dynamic> body, Function callback) async {
    ForgotPassModels model = await _repository.actForgotPass(body: body);
    callback(model.status, model.data);
  }

  dispose() {
    _forgotPassword.close();
  }
}

final bloc = ForgotPassBloc();
