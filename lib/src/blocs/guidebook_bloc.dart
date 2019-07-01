import 'package:jasindo_app/src/models/guidebook_model.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class GuideBookBloc {
  final _repository = Repository();
  final _guideBookBloc = PublishSubject<GuideBookModels>();

  guideBook(Map<String, dynamic> body, Function callback) async {
    GuideBookModels model = await _repository.fetchGuideBook(body: body);
    callback(model.status, model.message, model.data.url);
  }

  dispose() {
    _guideBookBloc.close();
  }
}

final bloc = GuideBookBloc();
