import 'package:jasindo_app/src/models/abouts_model.dart';
import 'package:jasindo_app/src/models/messages_model.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MessagesBloc {
  final _repository = Repository();
  final _messagesBloc = PublishSubject<MessagesModels>();

  Observable<MessagesModels> get postMessagesBloc => _messagesBloc.stream;

  messageBloc(Map<String, dynamic> body, Function(bool status, String message) callback) async {
    MessagesModels model = await _repository.actMessage(body);
    callback(model.status, model.message);
  }

  dispose() {
    _messagesBloc.close();
  }
}

final bloc = MessagesBloc();
