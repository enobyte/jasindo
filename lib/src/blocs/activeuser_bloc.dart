import 'package:jasindo_app/src/models/standart_model.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ActiveUserBloc {
  final _repository = Repository();
  final _activeUser = PublishSubject<StandartModels>();

  activeUser(Map<String, dynamic> body, Function callback) async {
    StandartModels model = await _repository.actActiveUser(body: body);
    callback(model.status, model.message);
  }

  dispose() {
    _activeUser.close();
  }
}

final bloc = ActiveUserBloc();
