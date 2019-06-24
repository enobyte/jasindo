import 'package:jasindo_app/src/models/abouts_model.dart';
import 'package:jasindo_app/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class AboutBloc {
  final _repository = Repository();
  final _aboutBloc = PublishSubject<AboutsModels>();

  Observable<AboutsModels> get getaboutBloc => _aboutBloc.stream;

  aboutBloc(
      Function(bool status, String message, AboutsModels model)
          callback) async {
    AboutsModels model = await _repository.fetchAbout();
    _aboutBloc.sink.add(model);
    callback(model.status, model.message, model);
  }

  dispose() {
    _aboutBloc.close();
  }
}

final bloc = AboutBloc();
